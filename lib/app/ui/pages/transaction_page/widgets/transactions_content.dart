import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/transaction_controller.dart';
import 'package:moneyapp/app/data/models/transaction_model.dart';
import 'package:moneyapp/app/routes/app_routes.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/assets_path.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/list_item_tile.dart';
import 'package:moneyapp/app/ui/global_widgets/text_amount.dart';
import 'package:moneyapp/app/ui/pages/transaction_page/widgets/payment_card.dart';
import 'package:moneyapp/app/ui/utils/extensions/date_time_ext.dart';

class TransactionsContent extends GetView<TransactionController> {
  const TransactionsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: cardSize / 2),
            color: AppColors.basicPurple,
            alignment: Alignment.center,
            child: Obx(() {
              return TextAmount(
                amount: controller.balance,
                smallStyle: AppTextStyles.balanceSmall,
                bigStyle: AppTextStyles.balanceBig,
                prefix: '£',
                color: Colors.white,
                prefixCapitalize: false,
              );
            }),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.only(top: cardSize / 2),
            color: AppColors.invisiblePurple,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15),
                Padding(
                  padding: UiConstants.horizontalPadding,
                  child: Text('Recent activity', style: AppTextStyles.transactionItemTitle.copyWith(color: AppColors.hoverBlack)),
                ),
                const SizedBox(height: 7),
                Expanded(
                  child: Obx(() {
                    final groups = groupBy<TransactionModel, DateTime>(
                      List.of(controller.transactionsList)..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
                      (model) => model.createdAt.clampedToDays,
                    );
                    // there are 2 implementations of the example list (slivers/regular list)
                    return _buildSliverList(groups);
                    // return _buildRegularList(groups);
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverList(Map<DateTime, List<TransactionModel>> groups) {
    final list = groups.entries.map((e) => [e.key, ...e.value]).expand((e) => e).toList();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: list.map((e) {
        if (e is DateTime) {
          return SliverAppBar(
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.invisiblePurple,
            toolbarHeight: 22,
            elevation: 0,
            title: Text(
              _getFormattedDate(e),
              style: AppTextStyles.groupsTitle,
            ),
          );
        } else if (e is TransactionModel) {
          final isTopUp = e.type == TransactionType.topUp;
          return SliverToBoxAdapter(
            child: ListItemTile(
              title: isTopUp ? 'Top Up' : e.name,
              icon: isTopUp ? AssetsPath.topUpIconPath : AssetsPath.paymentIconPath,
              onTap: () => Get.toNamed(AppRoutes.detailsRoutePath, arguments: e),
              trailing: TextAmount(
                amount: e.amount,
                smallStyle: AppTextStyles.transactionItemAmount.copyWith(fontSize: 16),
                bigStyle: AppTextStyles.transactionItemAmount,
                prefix: isTopUp ? '+' : null,
                prefixCapitalize: true,
                color: isTopUp ? AppColors.basicPurple : Colors.black,
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      }).toList(),
    );
  }

  // ignore: unused_element
  Widget _buildRegularList(Map<DateTime, List<TransactionModel>> groups) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: groups.entries.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: UiConstants.horizontalPadding.copyWith(top: 6, bottom: 6),
              child: Text(
                _getFormattedDate(e.key),
                style: AppTextStyles.groupsTitle,
              ),
            ),
            ...e.value.map((transaction) {
              final isTopUp = transaction.type == TransactionType.topUp;
              return ListItemTile(
                title: isTopUp ? 'Top Up' : transaction.name,
                icon: isTopUp ? AssetsPath.topUpIconPath : AssetsPath.paymentIconPath,
                onTap: () => Get.toNamed(AppRoutes.detailsRoutePath, arguments: e),
                trailing: TextAmount(
                  amount: transaction.amount,
                  smallStyle: AppTextStyles.transactionItemAmount.copyWith(fontSize: 16),
                  bigStyle: AppTextStyles.transactionItemAmount,
                  prefix: isTopUp ? '+' : null,
                  prefixCapitalize: true,
                  color: isTopUp ? AppColors.basicPurple : Colors.black,
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }

  String _getFormattedDate(DateTime date) {
    if (date.isToday) {
      return 'Today';
    } else if (date.isYesterday) {
      return 'Yesterday';
    } else {
      return date.formattedDate;
    }
  }
}
