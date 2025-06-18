// lib/src/widgets/search_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/prescription_provider.dart';

class SearchForm extends ConsumerStatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends ConsumerState<SearchForm> {
  final TextEditingController _ctrl = TextEditingController();

  void _applySearch(String value) {
    // Always fetch page 1 when searching or clearing
    ref.read(prescriptionProvider.notifier).fetchPage(1, search: value);
  }

  @override
  void initState() {
    super.initState();
    // Live-search as user types
    _ctrl.addListener(() {
      _applySearch(_ctrl.text);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                labelText: 'Buscar...',
                suffixIcon: _ctrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _ctrl.clear();
                          _applySearch('');
                        },
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: _applySearch, // on Enter
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _applySearch(_ctrl.text),
          ),
        ],
      ),
    );
  }
}
