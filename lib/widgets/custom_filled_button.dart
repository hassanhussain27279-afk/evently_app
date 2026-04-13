import 'package:evently_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 56)),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: AppColors.inputs)),
    );
  }
}
