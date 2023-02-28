import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataService {
  Future<List<dynamic>?> readLocalJson(String name) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$name.json');
    if (file.existsSync()) {
      final data = await file.readAsString();
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  void saveLocalJson(String name, List<Map<String, dynamic>> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$name.json');
    await file.writeAsString(jsonEncode(data));
  }
}
