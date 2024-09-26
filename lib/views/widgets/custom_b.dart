import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // يأخذ عرض كامل للعنصر الأب
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          height: 50.0, // تحديد ارتفاع ثابت للزر
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey[700] : Colors.black,
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
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
