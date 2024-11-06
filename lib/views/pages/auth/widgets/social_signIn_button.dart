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
    // Set text, icon, and color based on the sign-in type
    String buttonText;
    Widget buttonIcon;
    Color buttonColor;

    switch (signInType) {
      case SignInType.Google:
        buttonText = 'Sign in with Google';
        buttonIcon = Image.asset(
          'assets/image/google.png',
          color: Colors.white,
          width: 24.0,
          height: 24.0,
        ); // Use Google image
        buttonColor = Colors.blue;
        break;
      case SignInType.Apple:
        buttonText = 'Sign in with Apple';
        buttonIcon = Icon(
          Icons.apple,
          color: Colors.white,
          size: 24.0,
        ); // Use Apple icon
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