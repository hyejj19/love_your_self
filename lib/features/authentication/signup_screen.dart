import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/view_models/auth_view_model.dart';
import 'package:love_your_self/features/home/home_screen.dart';
import 'package:love_your_self/widgets/full_width_tap_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static String routePath = '/signup';
  static String routeName = 'signup';

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, String> formData = {};
  bool _isAbleToSignUp = false;

  void _onTapSignin() {
    Navigator.pop(context);
  }

  void _onSignUpAndLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      final authViewModel = ref.read(authViewModelProvider.notifier);

      try {
        await authViewModel.signUp(
          _emailController.text,
          _passwordController.text,
        );

        if (mounted) {
          context.go("/${HomeScreen.routeName}");
        }
      } catch (e) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text('회원가입 도중 에러가 발생했습니다.'),
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

  void _updateSignupButtonState() {
    final isValid = _formKey.currentState?.validate() ?? false;

    setState(() {
      _isAbleToSignUp = isValid;
    });
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_updateSignupButtonState);
    _passwordController.addListener(_updateSignupButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: _formKey,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    ),
                    const Gap(4),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
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
                    ),
                    const Gap(20),
                    FullWidthTapButton(
                      onTap: _onSignUpAndLogin,
                      isActive: _isAbleToSignUp,
                      text: "Sign up",
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: _onTapSignin,
            child: const Text(
              'Already have an account? Sign in',
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
