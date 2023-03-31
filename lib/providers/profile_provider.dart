import 'package:expense_tracker/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ProfileState { initial, loading, success, error }

class ProfileProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  ProfileState _profileState = ProfileState.initial;
  String _errorMessage = '';
  ProfileModel? _profileModel;

  ProfileState get profileState => _profileState;
  String get errorMessage => _errorMessage;
  ProfileModel? get profileModel => _profileModel;

  void setProfileState(ProfileState profileState) {
    _profileState = profileState;
    notifyListeners();
  }

  void resetProfileState() {
    _profileState = ProfileState.initial;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void getProfile() async {
    var id = await _storage.read(key: 'id');
    var fullName = await _storage.read(key: 'fullName');
    var email = await _storage.read(key: 'email');
    var role = await _storage.read(key: 'role');
    _profileModel = ProfileModel(
      id: id!,
      fullName: fullName!,
      email: email!,
      role: role!,
    );
    notifyListeners();
  }
}
