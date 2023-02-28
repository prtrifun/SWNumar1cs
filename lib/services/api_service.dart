import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> fetchData(String url, {List<Map<String, dynamic>> data = const []}) async {
    final List<Map<String, dynamic>> results = [...data];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      if (json['results'] != null) {
        for (var result in json['results']) {
          results.add(result);
        }
      }
      if (json['next'] != null) {
        return fetchData(json['next'], data: results);
      } else {
        return results;
      }
    } else {
      throw Exception(response.statusCode);
    }
  }
}
