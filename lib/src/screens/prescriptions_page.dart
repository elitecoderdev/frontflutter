import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/prescription_provider.dart';
import '../widgets/search_form.dart';
import '../widgets/prescription_tile.dart';

class PrescriptionsPage extends ConsumerWidget {
  const PrescriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(prescriptionProvider);
    final notifier = ref.read(prescriptionProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Prescripciones')),
      body: Column(
        children: [
          const SearchForm(),

          // Total results
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text('Total: ${notifier.totalRecords} resultados'),
          ),

          // List / states
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (e, _) => Center(child: Text('Error: $e')),

              data: (list) {
                if (list.isEmpty) {
                  // Empty + pull-to-refresh
                  return RefreshIndicator(
                    onRefresh: () => notifier.fetchPage(1),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text('No prescriptions found')),
                      ],
                    ),
                  );
                }

                // Infinite scroll + pull-to-refresh
                return NotificationListener<ScrollEndNotification>(
                  onNotification: (sn) {
                    final m = sn.metrics;
                    if (m.pixels >= m.maxScrollExtent - 100) {
                      notifier.loadMore();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () => notifier.fetchPage(1),
                    child: ListView.builder(
                      itemCount:
                          list.length +
                          (notifier.currentPage < notifier.totalPages ? 1 : 0),
                      itemBuilder: (ctx, i) {
                        if (i < list.length) {
                          return PrescriptionTile(list[i]);
                        }
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Manual pagination controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: notifier.currentPage > 1
                      ? () => notifier.fetchPage(notifier.currentPage - 1)
                      : null,
                ),
                Text('${notifier.currentPage} / ${notifier.totalPages}'),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: notifier.currentPage < notifier.totalPages
                      ? () => notifier.fetchPage(notifier.currentPage + 1)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
