import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_image.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.path,
    this.size = 16,
  }) : super(key: key);

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size / 4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppColors.basicPurple,
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomImage(imagePath: path, fit: BoxFit.fitHeight),
    );
  }
}
