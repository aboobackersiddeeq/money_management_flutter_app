
import 'package:hive_flutter/hive_flutter.dart';
 part 'category_model.g.dart';
@HiveType(typeId: 2)
enum CategoryType { 
  @HiveField(0)
  income,
  @HiveField(1)
   expense }
@HiveType(typeId: 1) 
class CategoryModal {
  @HiveField(0)
   int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final CategoryType type;
  @HiveField(3)
   bool isRemoved;

  CategoryModal({
    required this.name,
    required this.type,
    this.isRemoved = false,
    this.id,
  });
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs
