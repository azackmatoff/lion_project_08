import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lion_project_08/commons/constants/app_constants.dart';

class HttpServices {
  static final http.Client client = http.Client();

  static Future<Map<String, dynamic>> get(String currency) async {
    try {
      String url = '${AppConstants.apiUrl}BTC/$currency?apiKey=${AppConstants.apiKey}';

      Uri uri = Uri.parse(url);
      http.Response response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return data;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> post(String currency) async {
    try {
      String url = '${AppConstants.apiUrl}BTC/$currency?apiKey=${AppConstants.apiKey}';

      Uri uri = Uri.parse(url);
      http.Response response = await client.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return data;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
