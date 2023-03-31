class UrlEndpoints {
  static const String baseUrl = 'https://expense-tracker-backend.herokuapp.com/api/v1/';

  static const String login = '${baseUrl}auth/user/login';

  static const String getUserRequests = '${baseUrl}request/user-request';
  static const String createRequest = '${baseUrl}request/create';
  static const String getCategory = '${baseUrl}category';
  static const String getDepartment = '${baseUrl}department';
}
