import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';

enum TransactionType { payment, topUp }

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required final String id,
    required final String name,
    required final double amount,
    @Default(TransactionType.payment) final TransactionType type,
    required final DateTime createdAt,
  }) = _TransactionModel;

  const TransactionModel._();
}
