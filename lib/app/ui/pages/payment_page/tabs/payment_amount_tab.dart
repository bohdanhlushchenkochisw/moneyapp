import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/payment_controller.dart';
import 'package:moneyapp/app/controllers/transaction_controller.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/custom_elevated_button.dart';
import 'package:moneyapp/app/ui/global_widgets/text_amount.dart';
import 'package:moneyapp/app/ui/pages/payment_page/widgets/payment_keyboard.dart';

class PaymentAmountTab extends GetView<PaymentController> {
  const PaymentAmountTab({Key? key, required this.onNextTabRequest}) : super(key: key);

  final VoidCallback onNextTabRequest;

  bool get _isPayment => Get.arguments as bool;
  TransactionController get _transactionController => Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('How much?', style: AppTextStyles.balanceSmall),
              Obx(() {
                final value = controller.amount;
                final parts = value.split('.');
                return Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      alignment: Alignment.bottomCenter,
                      child: TextAmount(
                        amount: 0,
                        bigValue: parts.firstOrNull ?? '',
                        smallValue: parts.length >= 2 ? '.${parts.skip(1).join('.')}' : '',
                        smallStyle: AppTextStyles.balanceSmall,
                        bigStyle: AppTextStyles.balanceSmall.copyWith(fontSize: 70),
                        prefix: '£',
                        prefixCapitalize: false,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Visibility(
                      visible: controller.hasError.value,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Text('Wrong input', style: AppTextStyles.icon12W500.copyWith(color: AppColors.redAlert)),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              const PaymentKeyboard(),
              const Spacer(),
              Padding(
                padding: UiConstants.bigVerticalPadding,
                child: CustomElevatedButton(
                  text: _isPayment ? 'Next' : 'Pay',
                  onPressed: () {
                    if (controller.hasError.value) return;
                    if (_isPayment) {
                      onNextTabRequest();
                    } else {
                      _transactionController.addTopUpTransaction(double.parse(controller.amount));
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
