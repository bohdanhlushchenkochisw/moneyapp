import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/assets_path.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_image.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.hasBackButton,
    required this.hasCloseButton,
  }) : super(key: key);

  final bool hasBackButton;
  final bool hasCloseButton;

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.basicPurple,
      padding: UiConstants.appBarPadding,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Visibility(
              visible: hasBackButton,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(onPressed: Get.back, icon: const CustomImage(imagePath: AssetsPath.backIconPath, height: 16)),
            ),
            const Spacer(),
            Text('MoneyApp', style: AppTextStyles.basic16W600.copyWith(color: Colors.white)),
            const Spacer(),
            Visibility(
              visible: hasCloseButton,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(onPressed: Get.back, icon: const CustomImage(imagePath: AssetsPath.closeIconPath, height: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
