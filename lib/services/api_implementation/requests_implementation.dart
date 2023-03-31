import 'dart:convert';

import 'package:expense_tracker/constants/url_endpoints.dart';
import 'package:expense_tracker/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RequestsImpl implements RequestsService {
  final _storage = const FlutterSecureStorage();
  @override
  Future<ApiResponse> getUserRequests() async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse(UrlEndpoints.getUserRequests);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      final res = await http.get(url, headers: headers);
      final json = jsonDecode(res.body);
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

  @override
  Future<ApiResponse> createRequests(
    String title,
    String amount,
    String description,
    String category,
    String department,
    String media,
  ) async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse(UrlEndpoints.createRequest);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    request.fields.addAll({
      'title': title,
      'amount': amount,
      'description': description,
      'category': category,
      'department': department
    });
    if (media != '') {
      request.files.add(await http.MultipartFile.fromPath('media', media));
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      return ApiResponse(statusCode: 200, data: json, isError: false);
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        data: json,
        isError: true,
        errorMessage: response.reasonPhrase,
      );
    }
  }

  @override
  Future<ApiResponse> getCategories() async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse(UrlEndpoints.getCategory);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      final res = await http.get(url, headers: headers);
      final json = jsonDecode(res.body);
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

  @override
  Future<ApiResponse> getDepartments() async {
    String? token = await _storage.read(key: 'token');
    final url = Uri.parse(UrlEndpoints.getDepartment);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      final res = await http.get(url, headers: headers);
      final json = jsonDecode(res.body);
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

  @override
  Future<ApiResponse> getSpecificRequest() async {
    String? token = await _storage.read(key: 'token');
    String? uid = await _storage.read(key: 'id');
    final url = Uri.parse('${UrlEndpoints.getUserRequests}?userId=$uid');
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      final res = await http.get(url, headers: headers);
      final json = jsonDecode(res.body);
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
