import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/global_widgets/base_widget.dart';
import 'package:moneyapp/app/ui/pages/payment_page/tabs/payment_amount_tab.dart';
import 'package:moneyapp/app/ui/pages/payment_page/tabs/payment_to_tab.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: AppColors.basicPurple,
      hasCloseButton: true,
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PaymentAmountTab(
            onNextTabRequest: () => _tabController.animateTo(1),
          ),
          PaymentToTab(
            onPreviousPageRequest: () => _tabController.animateTo(0),
          ),
        ],
      ),
    );
  }
}
