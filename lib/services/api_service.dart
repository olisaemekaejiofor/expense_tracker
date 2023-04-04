abstract class AuthService {
  Future<ApiResponse> login(String email, String password);
  Future<ApiResponse> getDashboard();
}

abstract class RequestsService {
  Future<ApiResponse> getUserRequests();
  Future<ApiResponse> getSpecificRequest();
  Future<ApiResponse> getCategories();
  Future<ApiResponse> getDepartments();
  Future<ApiResponse> createRequests(
    String title,
    String amount,
    String description,
    String category,
    String department,
    String media,
  );
  Future<ApiResponse> updateRequestStatus(
    String requestId,
    String status,
  );

  Future<ApiResponse> getAccounts();
}

abstract class NotificationService {
  Future<ApiResponse> getNotifications();
}

class ApiResponse {
  final int statusCode;
  final dynamic data;
  final bool isError;
  final String? errorMessage;

  ApiResponse({
    required this.statusCode,
    required this.data,
    required this.isError,
    this.errorMessage,
  });
}
