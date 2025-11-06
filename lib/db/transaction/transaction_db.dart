import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/transaction/transaction_modal.dart';

const TRANSACTION_DB_NAME = "transaction_db";

abstract class TransactionDbFunctions {
  Future<void> insertTransaction(TransactionModal obj);
  Future<void> deleteTransaction(int id);
  Future<void> updateTransaction(int id, value);
  Future<List<TransactionModal>> getAllTransactions();
}

class TransactionDb implements TransactionDbFunctions {

  // creating a singleton pattern —
  // a design that ensures only one instance of a class exists throughout the app.
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }

  @override
  Future<void> deleteTransaction(int id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModal>> getAllTransactions() {
    // TODO: implement getAllTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> insertTransaction(TransactionModal obj) async {
    final db = await Hive.openBox<TransactionModal>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
  }

  @override
  Future<void> updateTransaction(int id, value) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
