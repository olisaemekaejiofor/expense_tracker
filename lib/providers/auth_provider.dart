import 'dart:developer';

import 'package:expense_tracker/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';

enum AuthState { initial, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();
  final _storage = const FlutterSecureStorage();
  AuthState _authState = AuthState.initial;
  String _errorMessage = '';
  String _role = '';

  AuthState get authState => _authState;
  String get errorMessage => _errorMessage;
  String get role => _role;

  void setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  void resetAuthState() {
    _authState = AuthState.initial;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setAuthState(AuthState.loading);
    var response = await _authService.login(email, password);
    if (response.isError) {
      log(response.errorMessage!);
      setErrorMessage(response.errorMessage!);
      setAuthState(AuthState.error);
    } else {
      _storage.write(key: 'token', value: response.data['data']['token']);
      _storage.write(key: 'id', value: response.data['data']['user']['_id']);
      _storage.write(key: 'fullName', value: response.data['data']['user']['fullName']);
      _storage.write(key: 'email', value: response.data['data']['user']['email']);
      _storage.write(key: 'role', value: response.data['data']['user']['role']);
      _storage.write(
          key: 'department', value: response.data['data']['user']['department']);
      setRole(response.data['data']['user']['role']);
      setAuthState(AuthState.success);
    }
  }

  Future<DashboardModel> getDashboard() async {
    var response = await _authService.getDashboard();
    if (response.isError) {
      log(response.errorMessage!);
      setErrorMessage(response.errorMessage!);

      return DashboardModel(
        data: [],
        msg: '',
        success: false,
      );
    } else {
      return DashboardModel.fromJson(response.data);
    }
  }
}
