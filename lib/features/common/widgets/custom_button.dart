import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? width;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(AppConstants.primaryColor),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: width ?? 100,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
