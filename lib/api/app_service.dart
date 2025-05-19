import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService.internal();

  factory ApiService() => instance;

  ApiService.internal();

  final String baseUrl = "https://pcs.kalelogistics.com/mswapi";

  Future<dynamic> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParams,
  }) async {
    Uri uri = Uri.parse("$baseUrl$endpoint");

    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    http.Response response;

    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final mergedHeaders = {...defaultHeaders, ...?headers};

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: mergedHeaders);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: mergedHeaders,
            body: jsonEncode(body),
          );
          break;
        default:
          throw Exception("HTTP method not supported");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
