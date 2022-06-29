import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/transaction_controller.dart';
import 'package:moneyapp/app/data/models/transaction_model.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/assets_path.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/base_widget.dart';
import 'package:moneyapp/app/ui/global_widgets/list_item_tile.dart';
import 'package:moneyapp/app/ui/global_widgets/svg_icon.dart';
import 'package:moneyapp/app/ui/global_widgets/text_amount.dart';
import 'package:moneyapp/app/ui/utils/extensions/date_time_ext.dart';

class DetailsPage extends GetView<TransactionController> {
  const DetailsPage({Key? key}) : super(key: key);

  TransactionModel get transaction => Get.arguments as TransactionModel;
  bool get isTopUp => transaction.type == TransactionType.topUp;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      hasBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTopPart(),
          const SizedBox(height: 30),
          const ListItemTile(icon: AssetsPath.receiptIconPath, title: 'Add receipt'),
          const SizedBox(height: 56),
          if (transaction.type == TransactionType.payment) ...<Widget>[
            _itemWithTitle(
              'Share the cost',
              'Split the bill',
              icon: AssetsPath.splitBillIconPath,
              onTap: () {
                controller.splitBill(transaction);
                Get.back();
              },
            ),
            const SizedBox(height: 30),
            _itemWithTitle(
              'Subscription',
              'Repeating payment',
              trailing: Obx(
                () => CupertinoSwitch(
                  value: controller.repeatingPayment.value,
                  onChanged: (value) => controller.togglePayment(value, transaction),
                ),
              ),
            ),
            const SizedBox(height: 55),
          ],
          ListItemTile(
            title: 'Something went wrong? Get help',
            textColor: AppColors.redAlert,
            fontWeight: FontWeight.w400,
            onTap: () => Get.defaultDialog(title: 'Help is on the way', middleText: 'Stay put!'),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Transaction ID #${transaction.id}\n${transaction.name} - Merchant ID #1234',
              style: AppTextStyles.groupsTitle,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _itemWithTitle(
    String title,
    String itemTitle, {
    String? icon,
    Widget? trailing,
    Color? textColor,
    FontWeight? fontWeight,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: UiConstants.horizontalPadding,
          child: Text(title, style: AppTextStyles.transactionItemTitle),
        ),
        const SizedBox(height: 3),
        ListItemTile(
          icon: icon,
          title: itemTitle,
          trailing: trailing,
          onTap: onTap,
          textColor: textColor,
          fontWeight: fontWeight,
        ),
      ],
    );
  }

  Widget _buildTopPart() {
    return Padding(
      padding: UiConstants.baseAllPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgIcon(
                path: isTopUp ? AssetsPath.topUpIconPath : AssetsPath.paymentIconPath,
                size: 64,
              ),
              const Spacer(),
              TextAmount(
                amount: transaction.amount,
                smallStyle: AppTextStyles.transactionDetailsAmountStyle,
                bigStyle: AppTextStyles.transactionDetailsAmountStyle.copyWith(fontSize: 37),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(transaction.name, style: AppTextStyles.transactionDetailsBig),
          ),
          Text(transaction.createdAt.formattedDateFull, style: AppTextStyles.groupsTitle),
        ],
      ),
    );
  }
}
