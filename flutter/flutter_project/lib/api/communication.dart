import 'dart:io';
import 'package:http/http.dart' as http;

class Communication {
  static const String baseURL = '10.0.2.2:3000';

  Map<String, String> getHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.http(baseURL, endpoint);
    final headers = getHeaders();
    dynamic res = await http.get(uri, headers: headers);
    return res;
  }
}
