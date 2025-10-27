/// Environment variables and app-wide constants
class Constants {
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  // Supabase
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL',
      defaultValue: 'https://your-project.supabase.co');
  static const String supabaseAnonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'your-anon-key-here');

  // App Info
  static const String appName = 'Kendin Yap Mobil';
  static const String appVersion = '1.0.0';

  // API Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Debug
  static const bool enableLogging = true;
  static const bool enableApiLogging = true;
}
