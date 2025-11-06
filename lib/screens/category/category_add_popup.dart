import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

void showCategoryPopup(context) async {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CategoryType? selectedType;

  void insertCategoryToDb(String name, CategoryType type) async {
    final newCategory = CategoryModal(name: name, type: type);
    await CategoryDb().insertCategory(newCategory);
    Navigator.pop(context);
  }

  await showDialog<Map<String, String>>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text("Add Category"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Category Name"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter a name" : null,
                ),
                const SizedBox(height: 15),
                const Text('Select Type'),
                RadioGroup<CategoryType>(
                  groupValue: selectedType,
                  onChanged: (value) => setState(() => selectedType = value),
                  child: Column(
                    children: const [
                      RadioListTile<CategoryType>(
                        title: Text('Income'),
                        value: CategoryType.income,
                      ),
                      RadioListTile<CategoryType>(
                        title: Text('Expense'),
                        value: CategoryType.expense,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate() && selectedType != null) {
                  insertCategoryToDb(nameController.text, selectedType!);
                } else if (selectedType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a type')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      );
    },
  );
}


// money_management_flutter_app