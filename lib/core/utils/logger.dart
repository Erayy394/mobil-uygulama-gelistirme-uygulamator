import 'package:flutter/foundation.dart';

/// Simple logger utility
class Logger {
  static void d(String message, [String? tag]) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toString().substring(11, 19);
      final prefix = tag != null ? '[$timestamp][$tag]' : '[$timestamp]';
      debugPrint('$prefix $message');
    }
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    debugPrint('[ERROR][$timestamp] $message');
    if (error != null) {
      debugPrint('[ERROR][$timestamp] Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('[ERROR][$timestamp] Stack: $stackTrace');
    }
  }

  static void w(String message) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    debugPrint('[WARN][$timestamp] $message');
  }

  static void i(String message) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    debugPrint('[INFO][$timestamp] $message');
  }
}
