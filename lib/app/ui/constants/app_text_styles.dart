import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_colors.dart';

abstract class AppTextStyles {
  static const basic16W600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const icon12W500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const balanceSmall = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.24,
  );

  static const balanceBig = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.24,
  );

  static const groupsTitle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.basicGrey,
    letterSpacing: -0.24,
  );

  static const transactionItemTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const transactionItemAmount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const transactionDetailsAmountStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const transactionDetailsBig = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: -0.24,
  );

  static const customButtonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.24,
  );
}
