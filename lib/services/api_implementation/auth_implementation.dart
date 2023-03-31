import 'dart:convert';
import 'dart:io';

import 'package:expense_tracker/constants/url_endpoints.dart';
import 'package:expense_tracker/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthImpl implements AuthService {
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
}
