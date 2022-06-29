import 'package:get/get.dart';
import 'package:moneyapp/app/controllers/transaction_controller.dart';

class CoreBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
