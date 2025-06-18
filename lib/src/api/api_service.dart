// lib/src/api/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // Use a static final (not const) so it can read at runtime
  static final String _baseUrl =
      dotenv.env['API_URL']?.trim() ?? 'http://localhost:8000';

  Future<Map<String, dynamic>> fetchPrescriptions({
    required int page,
    required int limit,
    String? search,
    String? startDate,
    String? endDate,
  }) async {
    final uri = Uri.parse('$_baseUrl/recipes').replace(
      queryParameters: {
        'page': '$page',
        'limit': '$limit',
        if (search != null) 'search': search,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
      },
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Error ${res.statusCode}');
    }
    return json.decode(res.body) as Map<String, dynamic>;
  }
}
