import 'package:get/get.dart';
import 'package:moneyapp/app/data/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class TransactionController extends GetxController {
  // uncomment this line and commented lines below to apply some test data
  // RxList<TransactionModel> transactionsList = _exampleData.obs;
  RxList<TransactionModel> transactionsList = <TransactionModel>[].obs;
  RxBool repeatingPayment = false.obs;

  double get balance => transactionsList.fold<double>(0, (p, e) {
        if (e.type == TransactionType.payment) {
          return p - e.amount;
        } else {
          return p + e.amount;
        }
      });

  void togglePayment(bool value, TransactionModel model) {
    repeatingPayment.value = value;
    if (value) {
      transactionsList.insert(0, model.copyWith(id: const Uuid().v4(), createdAt: DateTime.now()));
    }
  }

  void splitBill(TransactionModel model) {
    transactionsList.value = transactionsList.map((e) {
      if (e.id == model.id) {
        return model.copyWith(amount: model.amount / 2);
      } else {
        return e;
      }
    }).toList()
      ..add(
        model.copyWith(
          id: const Uuid().v4(),
          type: TransactionType.topUp,
          amount: model.amount / 2,
          createdAt: DateTime.now(),
        ),
      );
  }

  void addTopUpTransaction(double amount) {
    final model = TransactionModel(
      id: const Uuid().v4(),
      name: '',
      amount: amount,
      createdAt: DateTime.now(),
      type: TransactionType.topUp,
    );
    transactionsList.add(model);
  }

  void addPaymentTransaction(double amount, String name) {
    if (balance < amount) {
      Get.snackbar('Payment error', 'Not enough money');
      return;
    }
    final model = TransactionModel(
      id: const Uuid().v4(),
      name: name,
      amount: amount,
      createdAt: DateTime.now(),
    );
    transactionsList.add(model);
  }
}

// final _exampleData = <TransactionModel>[
//   TransactionModel(id: const Uuid().v4(), name: 'Test', amount: 10, createdAt: DateTime.now()),
//   TransactionModel(
//     id: const Uuid().v4(),
//     name: 'Test',
//     amount: 10,
//     createdAt: DateTime.now().subtract(const Duration(hours: 2)),
//     type: TransactionType.topUp,
//   ),
//   TransactionModel(
//     id: const Uuid().v4(),
//     name: 'Test',
//     amount: 10,
//     createdAt: DateTime.now().subtract(const Duration(days: 1)),
//     type: TransactionType.topUp,
//   ),
//   TransactionModel(id: const Uuid().v4(), name: 'Test', amount: 10, createdAt: DateTime.now().subtract(const Duration(days: 1))),
//   TransactionModel(
//     id: const Uuid().v4(),
//     name: 'Test',
//     amount: 10,
//     createdAt: DateTime.now().subtract(const Duration(days: 3)),
//     type: TransactionType.topUp,
//   ),
//   TransactionModel(id: const Uuid().v4(), name: 'Test', amount: 10, createdAt: DateTime.now().subtract(const Duration(days: 3))),
//   TransactionModel(
//     id: const Uuid().v4(),
//     name: 'Test',
//     amount: 10,
//     createdAt: DateTime.now().subtract(const Duration(days: 4)),
//     type: TransactionType.topUp,
//   ),
// ];
