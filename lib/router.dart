import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/login_screen.dart';
import 'package:love_your_self/features/authentication/signup_screen.dart';
import 'package:love_your_self/features/authentication/view_models/auth_view_model.dart';
import 'package:love_your_self/main_navigation_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: LoginScreen.routePath,
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) {
        final user = ref.read(authStateProvider).value;
        if (user != null) return '/home';

        return LoginScreen.routePath;
      },
    ),
    GoRoute(
      path: SignupScreen.routePath,
      name: SignupScreen.routeName,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/:tab(home|post)',
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.pathParameters['tab'];
        return MainNavigationScreen(tab: tab!);
      },
    ),
  ]);
});
