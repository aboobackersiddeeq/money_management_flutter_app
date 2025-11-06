import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});
    

  @override
  Widget build(BuildContext context) {
     final db = CategoryDb();
     return ValueListenableBuilder(
       valueListenable:  db.listenToCategories() ,
       builder: (context, Box<CategoryModal> box, _) {
       final filtered = box.values
            .where((cat) =>
                cat.type == CategoryType.income && cat.isRemoved == false)
            .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text('No income categories'));
        }
         return ListView.separated(
          itemBuilder: (ctx, index) {
          final category = filtered[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                // subtitle: Text(c),
                trailing: IconButton(onPressed: ()async {
                  if(category.id != null){
                  await db.deleteCategory(category.id!);
                  }
                }, icon: Icon(Icons.delete)),
              ),
            );
          },
          separatorBuilder: (ctx, index) => SizedBox(height: 10),
          itemCount: filtered.length,
             );
       }
     );
  }
}
