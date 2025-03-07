import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/signup_screen.dart';
import 'package:love_your_self/features/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routePath = '/';
  static String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void _onSingin() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        context.goNamed(HomeScreen.routeName);
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
                  GestureDetector(
                    onTap: _onSingin,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: _isAbleToLogin
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: _isAbleToLogin
                                ? Colors.white
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
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
