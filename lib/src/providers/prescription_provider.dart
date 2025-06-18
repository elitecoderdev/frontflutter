import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_service.dart';
import '../models/prescription.dart';

class PrescriptionNotifier
    extends StateNotifier<AsyncValue<List<Prescription>>> {
  PrescriptionNotifier() : super(const AsyncValue.loading()) {
    fetchPage(1);
  }

  final _api = ApiService();
  String? _search;
  final int _limit = 20;

  // Meta-data
  int totalRecords = 0;
  int totalPages = 0;
  int currentPage = 1;

  /// Fetch exactly one page (used for initial load, manual pagination, search).
  Future<void> fetchPage(int page, {String? search}) async {
    state = const AsyncValue.loading();
    // Update search filter (null = no filter)
    if (search != null) {
      final t = search.trim();
      _search = t.isEmpty ? null : t;
    }
    try {
      final result = await _api.fetchPrescriptions(
        page: page,
        limit: _limit,
        search: _search,
      );
      // Parse items
      final items = (result['data'] as List)
          .map((e) => Prescription.fromJson(e as Map<String, dynamic>))
          .toList();
      // Update meta
      final meta = result['meta'] as Map<String, dynamic>;
      totalRecords = meta['totalRecords'] as int;
      totalPages = meta['totalPages'] as int;
      currentPage = meta['currentPage'] as int;
      // Replace state
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Load next page and append (infinite scroll)
  Future<void> loadMore() async {
    if (currentPage >= totalPages) return;
    final next = currentPage + 1;
    final List<Prescription> prev = state.value ?? [];
    state = const AsyncValue.loading();
    try {
      final result = await _api.fetchPrescriptions(
        page: next,
        limit: _limit,
        search: _search,
      );
      final items = (result['data'] as List)
          .map((e) => Prescription.fromJson(e as Map<String, dynamic>))
          .toList();
      final meta = result['meta'] as Map<String, dynamic>;
      totalRecords = meta['totalRecords'] as int;
      totalPages = meta['totalPages'] as int;
      currentPage = meta['currentPage'] as int;
      state = AsyncValue.data([...prev, ...items]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final prescriptionProvider =
    StateNotifierProvider<PrescriptionNotifier, AsyncValue<List<Prescription>>>(
      (ref) => PrescriptionNotifier(),
    );
