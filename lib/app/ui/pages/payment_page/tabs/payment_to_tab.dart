import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/payment_controller.dart';
import 'package:moneyapp/app/controllers/transaction_controller.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_elevated_button.dart';

class PaymentToTab extends GetView<PaymentController> {
  const PaymentToTab({Key? key, required this.onPreviousPageRequest}) : super(key: key);

  final VoidCallback onPreviousPageRequest;

  TransactionController get _transactionController => Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    const borderStyle = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    );
    return WillPopScope(
      onWillPop: () async {
        onPreviousPageRequest();
        return false;
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: UiConstants.bigHorizontalPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text('To whom?', style: AppTextStyles.balanceSmall),
                  TextField(
                    onChanged: controller.updateTo,
                    style: AppTextStyles.balanceSmall.copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      focusedBorder: borderStyle,
                      enabledBorder: borderStyle,
                      disabledBorder: borderStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: UiConstants.bigVerticalPadding,
              alignment: Alignment.bottomCenter,
              child: CustomElevatedButton(
                text: 'Pay',
                onPressed: () {
                  Get.back();
                  _transactionController.addPaymentTransaction(
                    double.parse(controller.amount),
                    controller.to,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
