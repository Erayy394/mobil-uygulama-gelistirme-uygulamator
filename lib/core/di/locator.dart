import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/auth_api.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../shared/services/http_client.dart';
import '../../shared/services/storage.dart';
import '../../core/constants.dart';

final getIt = GetIt.instance;

/// Setup dependency injection
Future<void> setupLocator() async {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(
    SupabaseClient(Constants.supabaseUrl, Constants.supabaseAnonKey),
  );

  // Auth
  getIt.registerSingleton<AuthApi>(
    AuthApi(getIt<SupabaseClient>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(getIt<AuthApi>()),
  );

  // Services
  getIt.registerSingleton<HttpClient>(HttpClient());

  // Storage
  final storageService = StorageService();
  await storageService.initialize();
  getIt.registerSingleton<StorageService>(storageService);
}
