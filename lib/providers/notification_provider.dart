import 'package:flutter/material.dart';

import '../model/notification_model.dart';
import '../services/api_service.dart';
import '../services/service_locator.dart';

enum NotificationState { initial, loading, success, error }

class NotificationProvider extends ChangeNotifier {
  final _notificationService = serviceLocator<NotificationService>();
  NotificationModel? _notificationModel;
  NotificationState _notificationState = NotificationState.initial;
  String _errorMessage = '';

  NotificationState get notificationState => _notificationState;
  String get errorMessage => _errorMessage;
  NotificationModel? get notificationModel => _notificationModel;

  void setNotificationState(NotificationState notificationState) {
    _notificationState = notificationState;
    notifyListeners();
  }

  void resetNotificationState() {
    _notificationState = NotificationState.loading;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<NotificationModel> getNotifications() async {
    var response = await _notificationService.getNotifications();
    if (response.isError) {
      setErrorMessage(response.errorMessage!);
      setNotificationState(NotificationState.error);
      return NotificationModel(
        data: [],
        msg: '',
        success: false,
      );
    } else {
      _notificationModel = NotificationModel.fromJson(response.data);
      setNotificationState(NotificationState.success);
      return _notificationModel!;
    }
  }
}
