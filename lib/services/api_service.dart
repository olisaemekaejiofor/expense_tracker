abstract class AuthService {
  Future<ApiResponse> login(String email, String password);
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
