class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://api.brainapp.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String createPassword = '/auth/create-password';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Exercises
  static const String exercises = '/exercises';
  static String exerciseById(String id) => '/exercises/$id';

  // Games
  static const String games = '/games';
  static String gameById(String id) => '/games/$id';
  static String gameScore(String id) => '/games/$id/score';
}