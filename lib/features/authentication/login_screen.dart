import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/signup_screen.dart';
import 'package:love_your_self/features/authentication/view_models/auth_view_model.dart';
import 'package:love_your_self/features/home/home_screen.dart';
import 'package:love_your_self/widgets/full_width_tap_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routePath = '/';
  static String routeName = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, String> formData = {};
  bool _isAbleToLogin = false;

  void _updateLoginButtonState() {
    final isValid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _isAbleToLogin = isValid;
    });
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_updateLoginButtonState);
    _passwordController.addListener(_updateLoginButtonState);
  }

  Future<void> _onSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      final authViewModel = ref.read(authViewModelProvider.notifier);

      try {
        // 로그인 시도
        await authViewModel.signIn(
          _emailController.text,
          _passwordController.text,
        );

        // 로그인 성공 시 HomeScreen으로 이동
        if (mounted) {
          context.go("/${HomeScreen.routeName}");
        }
      } catch (e) {
        print('에러발생!!');
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text('로그인 도중 에러가 발생했습니다.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }

        return;
      }
    }
  }

  void _onTapSignup() {
    context.push(SignupScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'How Do You Feel?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                  const Gap(10),
                  Container(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200,
                      ),
                      child: Image.asset(
                          'assets/images/mood_tracker_app_icon.png')),
                  const Gap(60),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter your email.";
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (value != null && !emailRegex.hasMatch(value)) {
                            return "Invalid email format";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['email'] = newValue;
                          }
                        },
                      ),
                      const Gap(4),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter your password.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['password'] = newValue;
                          }
                        },
                      ),
                    ]),
                  ),
                  const Gap(20),
                  FullWidthTapButton(
                    onTap: _onSignIn,
                    isActive: _isAbleToLogin,
                    text: "Sign in",
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: _onTapSignup,
            child: Text(
              'Sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ));
  }
}
