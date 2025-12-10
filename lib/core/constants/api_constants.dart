class ApiConstants {
  static const String baseUrl = 'https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock';

  static String getUserUrl(String userId) => '$baseUrl/users/$userId';

  static const String emptyUserIdError = 'Please enter a user ID';
  static const String genericError = 'Something went wrong';
}