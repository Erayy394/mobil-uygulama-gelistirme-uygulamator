import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/domain/user.dart';

/// Global app state
class AppState {
  final User? user;
  final String? currentProjectId;

  AppState({
    this.user,
    this.currentProjectId,
  });

  bool get isAuthenticated => user != null;
}

/// App state notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void setUser(User user) {
    state = AppState(
      user: user,
      currentProjectId: state.currentProjectId,
    );
  }

  void clearUser() {
    state = AppState(
      user: null,
      currentProjectId: state.currentProjectId,
    );
  }

  void setCurrentProject(String projectId) {
    state = AppState(
      user: state.user,
      currentProjectId: projectId,
    );
  }
}

/// App state provider
final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
