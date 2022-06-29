import 'package:get/get.dart';
import 'package:moneyapp/app/ui/utils/extensions/string_ext.dart';

class PaymentController extends GetxController {
  final RxString _amount = ''.obs;
  RxBool hasError = false.obs;
  String _to = '';

  String get amount {
    if (_amount.value.isNotEmpty) {
      return _amount.value;
    } else {
      return '0.0';
    }
  }

  String get to => _to;

  void handleTap(String key) {
    if (key == 'r') {
      _amount.value = _amount.value.removeLast();
    } else {
      _amount.value += key;
    }
    hasError.value = double.tryParse(_amount.value) == null;
  }

  void updateTo(String value) => _to = value;
}
