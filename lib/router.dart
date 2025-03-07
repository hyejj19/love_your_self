import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/login_screen.dart';
import 'package:love_your_self/features/authentication/signup_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: LoginScreen.routePath,
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/signup',
    name: 'signup',
    builder: (context, state) => const SignupScreen(),
  ),
]);
