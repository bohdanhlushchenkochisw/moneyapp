import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/global_widgets/base_widget.dart';
import 'package:moneyapp/app/ui/pages/transaction_page/widgets/payment_card.dart';
import 'package:moneyapp/app/ui/pages/transaction_page/widgets/transactions_content.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: AppColors.basicPurple,
      child: Stack(
        children: const <Widget>[
          TransactionsContent(),
          PaymentCard(),
        ],
      ),
    );
  }
}
