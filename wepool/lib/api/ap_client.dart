import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiClient {
  final String baseUrl;
  final logger = Logger();

  ApiClient(this.baseUrl);

  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    Uri uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: params);
    logger.i("📤 Sending GET request to: $uri");
    try {
      final response = await http.get(uri);
      return _processResponse(response);
    } catch (e) {
      logger.e("❌ Exception during GET request: $e");
      throw Exception("Network error: $e");
    }
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final url = Uri.parse(baseUrl + endpoint);
      logger.i("📡 POST Request: $url");
      logger.d("📦 Request Body: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (e, stacktrace) {
      logger.e(
        "🚨 Exception in POST request",
        error: e,
        stackTrace: stacktrace,
      );
      return null;
    }
  }


  dynamic _processResponse(http.Response response) {
    logger.i("🔄 Processing Response...");

    try {
      var responseJson = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i("✅ SUCCESS: ${response.statusCode}");
        return responseJson;
      } else {
        logger.w("⚠️ API ERROR: ${response.statusCode}");
        return {
          "success": false,
          "message": responseJson["message"] ?? "Unknown API error"
        };
      }
    } catch (e) {
      logger.e("🚨 Error processing response: ${e.toString()}");
      return {"success": false, "message": "Invalid response format", "status": response.statusCode};
    }
  }


}
