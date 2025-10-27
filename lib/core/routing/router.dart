import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../../features/auth/presentation/sign_in_page.dart';
import '../../features/auth/presentation/sign_up_page.dart';
import '../../features/builder/presentation/advanced_builder_page.dart';
import '../../features/runtime/presentation/renderer.dart';

/// Build application router
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: Routes.signIn,
    routes: [
      GoRoute(
        path: Routes.signIn,
        name: 'sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: Routes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: Routes.builder,
        name: 'builder',
        builder: (context, state) {
          final projectId = 'project-1';
          return AdvancedBuilderPage(projectId: projectId);
        },
      ),
      GoRoute(
        path: Routes.preview,
        name: 'preview',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'] ?? '';
          return RuntimePreviewPage(projectId: projectId);
        },
      ),
    ],
    // TODO: Add redirect for auth guard
    // redirect: (context, state) {
    //   final isLoggedIn = ref.read(authProvider).isAuthenticated;
    //   final isGoingToAuth = state.matchedLocation == Routes.signIn ||
    //                         state.matchedLocation == Routes.signUp;
    //
    //   if (!isLoggedIn && !isGoingToAuth) {
    //     return Routes.signIn;
    //   }
    //   if (isLoggedIn && isGoingToAuth) {
    //     return Routes.projects;
    //   }
    //   return null;
    // },
  );
}
