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

  @override
  Widget build(BuildContext context) {
    final auth_Provider = Provider.of<Auth_Provider>(context);

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
                          }
                          return null;
                        },
                        hintText: '',
                      ),
                      const SizedBox(height: 20),
                      auth_Provider.isLoading
                          ? CircularProgressIndicator()
                          : AuthButton(
                              text: 'Creat',
                              onPressed: () {
                                auth_Provider.registerWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  fullName: fullNameController.text,
                                  context: context,
                                );
                              },
                            ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Google,
                        onPressed: () {
                          auth_Provider.signInWithGoogle(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Apple,
                        onPressed: () {
                          auth_Provider.signInWithApple(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      if (auth_Provider.errorMessage != null)
                        Text(
                          auth_Provider.errorMessage!,
                          style: TextStyle(color: Colors.red),
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
