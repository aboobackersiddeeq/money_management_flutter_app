import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_modal.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = TransactionDb.instance;
    return ValueListenableBuilder(
      valueListenable: db.listenToTransactions(),
      builder: (context, Box<TransactionModal> box, _) {
        final transactions = box.values.toList();

        // Sort transactions by date in descending order
        transactions.sort((a, b) => b.date.compareTo(a.date));
        if (transactions.isEmpty) {
          return const Center(child: Text('No transactions added yet!'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final transaction = transactions[index];
            return Card(
              elevation: 0,
              child: Slidable(
                key: Key(transaction.id!),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        if (transaction.id != null) {
                          await db.deleteTransaction(transaction.id!);
                        }
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        if (transaction.id != null) {
                          // await db.deleteTransaction(transaction.id!);
                        }
                      },
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      icon: Icons.cancel,
                      label: 'Cancel',
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: transaction.type == CategoryType.income
                        ? Colors.green[100]
                        : Colors.red[100],
                    child: Text(
                      parseDate(transaction.date),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text(transaction.amount.toString()),
                  trailing: Column(
                    children: [
                      Text(transaction.category.name),
                      Text(transaction.type.name),
                    ],
                  ),
                  subtitle: Text(transaction.purpose.toString()),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 1);
          },
          itemCount: transactions.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = monthNames[date.month - 1];
    // final year = date.year.toString();
    return '$day\n$month';
  }
}
