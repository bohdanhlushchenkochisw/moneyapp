import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/routes/app_routes.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/assets_path.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_image.dart';

const cardSize = 100.0;

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: UiConstants.horizontalPadding.copyWith(top: (constraints.maxHeight / 3) - (cardSize / 2)),
          elevation: 10,
          child: Container(
            padding: UiConstants.basePadding,
            height: cardSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildItem(AssetsPath.phoneIconPath, 'Pay', true),
                _buildItem(AssetsPath.walletIconPath, 'Top up', false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(String icon, String text, bool isPayment) {
    return IconButton(
      onPressed: () => Get.toNamed(AppRoutes.payRoutePath, arguments: isPayment),
      iconSize: 72,
      padding: EdgeInsets.zero,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomImage(imagePath: icon),
          Text(text, style: AppTextStyles.icon12W500),
        ],
      ),
    );
  }
}
