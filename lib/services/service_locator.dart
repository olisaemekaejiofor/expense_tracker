import 'package:expense_tracker/services/api_implementation/auth_implementation.dart';
import 'package:expense_tracker/services/api_implementation/notification_implementation.dart';
import 'package:expense_tracker/services/api_implementation/requests_implementation.dart';
import 'package:expense_tracker/services/api_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //services
  serviceLocator.registerLazySingleton<AuthService>(() => AuthImpl());
  serviceLocator.registerLazySingleton<RequestsService>(() => RequestsImpl());
  serviceLocator.registerLazySingleton<NotificationService>(() => NotificationImpl());
}
