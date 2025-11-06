 import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/category/category_model.dart';
const CATEGORY_DB_NAME = "category_db";


 abstract class CategoryDbFunctions {
// 
  Future<void> insertCategory(CategoryModal value);
  Future<void> deleteCategory(int id);
  Future<void> updateCategory(int id,value);
  Future<List<CategoryModal>> getAllCategories();
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModal value) async{
    final categoryDb = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    final id = await categoryDb.add(value);
    value.id = id;
    await categoryDb.put(id, value); 
  }
  @override
  Future<List<CategoryModal>> getAllCategories() async {
    final categoryDb = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    return categoryDb.values.toList();
  }
  
  @override
  Future<void> deleteCategory(int id)async {
    final categoryDb = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
     var item = categoryDb.get(id);
       if (item != null) {
      item.isRemoved = true;
      await categoryDb.put(id, item);// ✅ updates the record
    }
  }
  
  @override
  Future<void> updateCategory(int id, value) async{
    final categoryDb = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    await categoryDb.put(id, value);
  }
  
  // Listen for real-time updates
  ValueListenable<Box<CategoryModal>> listenToCategories() {
    final categoryDb = Hive.box<CategoryModal>(CATEGORY_DB_NAME);
    return categoryDb.listenable();
  }
}