import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading; // Control loading state
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        TextFormField(
          enabled: !isLoading,
          inputFormatters: inputFormatters,
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            hintText: hintText,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Aligns icon to bottom-right
                  child: suffixIcon,
                )
              : null,
          ),
        ),
      ],
    );
  }
}
