import 'package:get/get.dart';
import 'package:moneyapp/app/bindings/payment_binding.dart';
import 'package:moneyapp/app/routes/app_routes.dart';
import 'package:moneyapp/app/ui/pages/details_page/details_page.dart';
import 'package:moneyapp/app/ui/pages/payment_page/payment_page.dart';
import 'package:moneyapp/app/ui/pages/transaction_page/transaction_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.initialRoutePath, page: () => const TransactionPage()),
    GetPage(name: AppRoutes.detailsRoutePath, page: () => const DetailsPage()),
    GetPage(name: AppRoutes.payRoutePath, page: () => const PaymentPage(), binding: PaymentBinding()),
  ];
}
