import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/payment_controller.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';

class PaymentKeyboard extends GetView<PaymentController> {
  const PaymentKeyboard({Key? key}) : super(key: key);

  static const _keyboardButtons = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['.', '0', 'r']
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConstants.horizontalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _keyboardButtons.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row.map(_keyboardItem).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _keyboardItem(String key) {
    return IconButton(
      onPressed: () => controller.handleTap(key),
      icon: key == 'r' ? const Icon(Icons.arrow_back_ios, color: Colors.white) : Text(key, style: AppTextStyles.balanceSmall),
    );
  }
}
