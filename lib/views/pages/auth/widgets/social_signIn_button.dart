import 'package:flutter/material.dart';

enum SignInType { Google, Apple }

class SocialSignInButton extends StatelessWidget {
  final SignInType signInType;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialSignInButton({
    Key? key,
    required this.signInType,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // اختيار النص والأيقونة بناءً على نوع تسجيل الدخول
    String buttonText;
    Widget buttonIcon;
    Color buttonColor;

    switch (signInType) {
      case SignInType.Google:
        buttonText = 'تسجيل بواسطة Google';
        buttonIcon = Image.asset(
          'assets/image/google.png',
          color: Colors.white,
          width: 24.0,
          height: 24.0,
        ); // استخدام صورة Google
        buttonColor = Colors.blue;
        break;
      case SignInType.Apple:
        buttonText = 'تسجيل بواسطة Apple';
        buttonIcon = Icon(
          Icons.apple,
          color: Colors.white,
          size: 24.0,
        ); // استخدام أيقونة Apple
        buttonColor = Colors.black;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey[700] : buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonIcon,
                    const SizedBox(width: 8.0),
                    Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
