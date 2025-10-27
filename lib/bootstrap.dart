import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/constants.dart';
import 'core/utils/logger.dart';

/// Bootstrap the application
Future<void> bootstrap() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  Logger.i('Starting app in ${Constants.env} mode');

  // Initialize Hive for local storage
  try {
    await Hive.initFlutter();
    Logger.i('Hive initialized');
  } catch (e) {
    Logger.e('Failed to initialize Hive', e);
  }

  // Load environment configuration
  // await _loadEnvironment();

  // Run app with error handling
  runZonedGuarded(() {
    runApp(const ProviderScope(child: App()));
  }, (error, stackTrace) {
    Logger.e('Uncaught error', error, stackTrace);
    // TODO: Report to crash analytics
  });
}

/// Load environment configuration
Future<void> _loadEnvironment() async {
  // Load from env/*.json based on Constants.env
  // final envFile = 'env/env_${Constants.env}.json';
  // try {
  //   final file = File(envFile);
  //   if (await file.exists()) {
  //     final content = await file.readAsString();
  //     final env = jsonDecode(content) as Map<String, dynamic>;
  //     // Apply to constants
  //     Logger.i('Environment loaded from $envFile');
  //   }
  // } catch (e) {
  //   Logger.e('Failed to load environment', e);
  // }
}
