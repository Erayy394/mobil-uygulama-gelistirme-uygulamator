import 'package:hive/hive.dart';
import '../../core/utils/logger.dart';

/// Local storage service using Hive
class StorageService {
  static const String _boxName = 'app_storage';
  Box? _box;

  /// Initialize storage
  Future<void> initialize() async {
    try {
      _box = await Hive.openBox(_boxName);
      Logger.i('Storage initialized');
    } catch (e) {
      Logger.e('Failed to initialize storage', e);
    }
  }

  /// Get value by key
  T? get<T>(String key) {
    try {
      return _box?.get(key) as T?;
    } catch (e) {
      Logger.e('Failed to get $key', e);
      return null;
    }
  }

  /// Save value by key
  Future<void> set<T>(String key, T value) async {
    try {
      await _box?.put(key, value);
    } catch (e) {
      Logger.e('Failed to set $key', e);
    }
  }

  /// Delete value by key
  Future<void> delete(String key) async {
    try {
      await _box?.delete(key);
    } catch (e) {
      Logger.e('Failed to delete $key', e);
    }
  }

  /// Clear all data
  Future<void> clear() async {
    try {
      await _box?.clear();
    } catch (e) {
      Logger.e('Failed to clear storage', e);
    }
  }
}
