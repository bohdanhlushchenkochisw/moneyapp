import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/app/bindings/transaction_binding.dart';
import 'package:moneyapp/app/routes/app_pages.dart';
import 'package:moneyapp/app/routes/app_routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialBinding: CoreBindings(),
      initialRoute: AppRoutes.initialRoutePath,
      getPages: AppPages.pages,
    ),
  );
}
