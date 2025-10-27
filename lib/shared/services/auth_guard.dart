import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/routing/routes.dart';
import '../state/app_state.dart';

/// Auth guard for routes
class AuthGuard {
  static String? checkAuth(WidgetRef ref, String currentPath) {
    final state = ref.read(appStateProvider);

    if (!state.isAuthenticated &&
        currentPath != Routes.signIn &&
        currentPath != Routes.signUp) {
      return Routes.signIn;
    }

    if (state.isAuthenticated &&
        (currentPath == Routes.signIn || currentPath == Routes.signUp)) {
      return Routes.builder;
    }

    return null;
  }
}
