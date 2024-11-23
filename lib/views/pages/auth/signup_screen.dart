import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/provider/auth_provider.dart';
import 'package:cube_business/views/pages/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_button.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_textfiled.dart';
import 'package:cube_business/views/pages/auth/widgets/social_signIn_button.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
final String _errorMsg="";

  SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth_Provider>(context);

    return Scaffold(
      body: MyBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: fullNameController,
                        labelText: 'Name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: emailController,
                        labelText: 'Email',
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }else if (value.length<6){return 'Password should be at least 6 characters';}
                          return null;
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      authProvider.isLoading
                          ? const CircularProgressIndicator()
                          : AuthButton(
                              text: 'Creat New Account',
                              onPressed: () {
                          authProvider.registerWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  fullName: fullNameController.text,
                                  context: context,
                                );
                                // _errorMsg=respone;
                              },
                            ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Google,
                        onPressed: () {
                          authProvider.signInWithGoogle(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Apple,
                        onPressed: () {
                          authProvider.signInWithApple(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      if (authProvider.errorMessage != null)
                        Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By signing up, you agree to the ',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontFamily: 'cubefont'),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: const TextStyle(
                                color: Colors.blue, // Link color
                                decoration: TextDecoration
                                    .underline, // Underline for the link
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Execute when tapping on the link
                                  print("Navigating to Terms and Conditions");
                                  // You can add logic here to open the Terms and Conditions page
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          navigateAndRemove(context, LoginScreen());
                        },
                        child: const Text(
                          'or Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue, // لون النص
                            decoration:
                                TextDecoration.underline, // تحت الخط للنص
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