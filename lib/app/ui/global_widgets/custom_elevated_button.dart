import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fixedSize = const Size(200, 60),
  }) : super(key: key);

  final String text;
  final Size fixedSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        primary: AppColors.invisiblePurple.withOpacity(0.5),
        fixedSize: fixedSize,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        text,
        style: AppTextStyles.customButtonStyle,
      ),
    );
  }
}
