import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final db = CategoryDb.instance;
    return ValueListenableBuilder(
      valueListenable: db.listenToCategories(),
      builder: (context, Box<CategoryModal> box, _) {
        final filtered = box.values
            .where(
              (cat) =>
                  cat.type == CategoryType.expense && cat.isRemoved == false,
            )
            .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text('No Expense categories'));
        }

        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = filtered[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                // subtitle: Text("sub"),
                trailing: IconButton(
                  onPressed: () async {
                    if (category.id != null) {
                      await db.deleteCategory(category.id!);
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) => SizedBox(height: 10),
          itemCount: filtered.length,
        );
      },
    );
  }
}
