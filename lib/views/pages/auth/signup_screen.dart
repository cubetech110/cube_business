import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/auth/login_screen.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_button.dart';
import 'package:cube_business/views/pages/auth/widgets/auth_textfiled.dart';
import 'package:cube_business/views/pages/auth/widgets/social_signIn_button.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final AuthService _authService = AuthService();

  final TextEditingController passwordController = TextEditingController();

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
                  maxWidth:
                      600, // عرض محدد للحفاظ على التناسب على الشاشات الكبيرة
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'قم بإنشاء حسابك 🤩',
                        style: TextStyle(
                          fontSize: 24, // حجم الخط
                          fontWeight: FontWeight.bold, // سماكة الخط
                          color: Colors.black87, // لون الخط
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: fullNameController,
                        labelText: 'الاسم',
                        hintText: '',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                      AuthButton(
                        text: 'تسجيل',
                        onPressed: () async {
                          await _authService.registerWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text);
                        },
                      ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Google,
                        onPressed: () {
                          // منطق تسجيل الدخول عبر Google
                        },
                      ),
                      const SizedBox(height: 10),
                      SocialSignInButton(
                        signInType: SignInType.Apple,
                        onPressed: () {
                          // منطق تسجيل الدخول عبر Apple
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
