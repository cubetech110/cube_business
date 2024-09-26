import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/auth/signup_screen.dart';
import 'package:cube_business/views/pages/add%20store/add_store.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_button.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_textfiled.dart';
import 'package:cube_business/views/pages/auth/widgets/social_signIn_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  void _showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  void _hideError() {
    setState(() {
      _errorMessage = null;
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _hideError();
    });

    final user = await _authService.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (user == null) {
      _showError('Failed to sign in. Please check your credentials.');
      return;
    }

    final currentUserData = await _authService.getCurrentUserData();

    if (currentUserData == null) {
      _showError('No user data found. Please try again.');
    } else {
      navigateAndRemove(context, const EnterDetailsScreen());
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
      _hideError();
    });

    final user = await _authService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user == null) {
      _showError('Failed to sign in with Google. Please try again.');
      return;
    }

    navigateAndRemove(context,  HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600, // Max width for larger screens
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'قم بتسجيل دخولك 🤩',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: emailController,
                        labelText: 'البريد الالكتروني',
                        hintText: '',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: passwordController,
                        labelText: 'كلمة المرور',
                        hintText: 'كلمة المرور',
                        obscureText: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 10),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : AuthButton(
                              text: 'تسجيل الدخول',
                              onPressed: _login,
                            ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Google,
                        onPressed: _loginWithGoogle,
                      ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Apple,
                        onPressed: () {
                          // Handle Apple Sign-In
                        },
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'عند التسجيل فأنت توافق على ',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontFamily: 'cubefont'),
                          children: [
                            TextSpan(
                              text: 'الشروط و الاحكام',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Terms and Conditions tap
                                  print("Navigating to Terms and Conditions");
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          navigateAndRemove(context, SignupScreen());
                        },
                        child: const Text(
                          'أو انشئ حساب',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
