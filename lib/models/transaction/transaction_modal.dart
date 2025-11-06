import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/category/category_model.dart';
 part 'transaction_modal.g.dart';

@HiveType(typeId: 3)
class TransactionModal {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModal category;
  @HiveField(5)
  String? id;
  
  TransactionModal({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    // this.id,
  }){
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
