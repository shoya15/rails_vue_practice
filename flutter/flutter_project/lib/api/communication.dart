import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<dynamic> post(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint);
    final headers = getHeaders();
    dynamic res = await http.post(uri, headers: headers, body: jsonEncode(params));
    return res;
  }

  Future<dynamic> put(String endpoint, [params]) async {
    final uri = Uri.http(baseURL, endpoint);
    final headers = getHeaders();
    dynamic res = await http.put(uri, headers: headers, body: jsonEncode(params));
    return res;
  }

  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.http(baseURL, endpoint);
    final headers = getHeaders();
    dynamic res = await http.delete(uri, headers: headers);
    return res;
  }
}
