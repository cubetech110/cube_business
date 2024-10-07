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
                        'قم بإنشاء حسابك 🤩',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: fullNameController,
                        labelText: 'الاسم',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        }, hintText: '',
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: emailController,
                        labelText: 'البريد الالكتروني',
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        }, hintText: '',
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: passwordController,
                        labelText: 'كلمة المرور',
                        obscureText: true,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        }, hintText: '',
                      ),
                      const SizedBox(height: 20),
                      auth_Provider.isLoading
                          ? CircularProgressIndicator()
                          : AuthButton(
                              text: 'تسجيل',
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
                          text: 'عند التسجيل فأنت توافق على ',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontFamily: 'cubefont'),
                          children: [
                            TextSpan(
                              text: 'الشروط و الاحكام',
                              style: const TextStyle(
                                color: Colors.blue, // لون الرابط
                                decoration:
                                    TextDecoration.underline, // تحت الخط للرابط
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // تنفيذ عند النقر على الرابط
                                  print("Navigating to Terms and Conditions");
                                  // يمكنك تنفيذ المنطق لفتح صفحة الشروط والأحكام هنا
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
                          'او سجل دخولك',
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
