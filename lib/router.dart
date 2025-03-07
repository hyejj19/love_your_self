import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/login_screen.dart';
import 'package:love_your_self/features/authentication/signup_screen.dart';
import 'package:love_your_self/features/home/home_screen.dart';
import 'package:love_your_self/main_navigation_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: LoginScreen.routePath,
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
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
