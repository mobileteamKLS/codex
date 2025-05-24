import 'dart:convert';
import 'package:codex_pcs/utils/common_utils.dart';
import 'package:http/http.dart' as http;

import '../core/global.dart';

class ApiService {
  static final ApiService instance = ApiService.internal();

  factory ApiService() => instance;

  ApiService.internal();

   String baseUrl = mobileBaseURL;

  Future<dynamic> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    dynamic body,
    bool includeApiKey = true,
    bool includeToken = true,
    Map<String, String>? queryParams,
  }) async {
    Uri uri = Uri.parse("$mobileBaseURL$endpoint");

    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    http.Response response;

    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (includeApiKey) {
      defaultHeaders['API-Key'] = configMaster.clientRequestID;
    }
    if (includeToken) {
      defaultHeaders['Authorization'] ="Bearer ${loginDetailsMaster.token}";
    }

    final mergedHeaders = {...defaultHeaders, ...?headers};
    Utils.prints(endpoint, mobileBaseURL);
    Utils.prints("BODY", json.encode(body));
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
