import 'dart:convert';

import 'package:expense_tracker/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../constants/url_endpoints.dart';

class NotificationImpl implements NotificationService {
  final _storage = const FlutterSecureStorage();
  @override
  Future<ApiResponse> getNotifications() async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse(UrlEndpoints.getNotifications);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var res = await http.get(url, headers: headers);
      var json = jsonDecode(res.body);
      switch (res.statusCode) {
        case 200:
          return ApiResponse(statusCode: 200, data: json, isError: false);
        default:
          return ApiResponse(
            statusCode: res.statusCode,
            data: json,
            isError: true,
            errorMessage: json['message'],
          );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        data: null,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }
}
