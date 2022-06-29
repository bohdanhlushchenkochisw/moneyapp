import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_app_bar.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    Key? key,
    required this.child,
    this.hasBackButton = false,
    this.hasCloseButton = false,
    this.backgroundColor = AppColors.invisiblePurple,
  }) : super(key: key);

  final bool hasBackButton;
  final bool hasCloseButton;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(hasBackButton: hasBackButton, hasCloseButton: hasCloseButton),
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}
