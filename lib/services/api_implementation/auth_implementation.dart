import 'dart:convert';
import 'dart:io';

import 'package:expense_tracker/constants/url_endpoints.dart';
import 'package:expense_tracker/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthImpl implements AuthService {
  final _storage = const FlutterSecureStorage();
  @override
  Future<ApiResponse> login(String email, String password) async {
    final url = Uri.parse(UrlEndpoints.login);
    final body = {
      'email': email,
      'password': password,
    };
    try {
      final response = http.post(
        url,
        body: body,
      );
      return response.then((value) {
        var json = jsonDecode(value.body);
        if (value.statusCode == 200) {
          return ApiResponse(
            statusCode: value.statusCode,
            data: json,
            isError: false,
          );
        } else {
          return ApiResponse(
            statusCode: value.statusCode,
            data: json,
            isError: true,
            errorMessage: json['message'],
          );
        }
      });
    } on SocketException {
      return ApiResponse(
        statusCode: 500,
        data: null,
        isError: true,
        errorMessage: 'No Internet Connection',
      );
    } on FormatException {
      return ApiResponse(
        statusCode: 500,
        data: null,
        isError: true,
        errorMessage: 'Invalid Response',
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 500,
        data: null,
        isError: true,
        errorMessage: 'Something went wrong',
      );
    }
  }

  @override
  Future<ApiResponse> getDashboard() async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse('${UrlEndpoints.baseUrl}transaction/payout/department');
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
