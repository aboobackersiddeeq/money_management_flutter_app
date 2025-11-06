import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/transaction/transaction_modal.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = TransactionDb.instance;
    return ValueListenableBuilder(
      valueListenable: db.listenToTransactions(),
      builder: (context, Box<TransactionModal> box, _) {
        final transactions = box.values.toList();
        if (transactions.isEmpty) {
          return const Center(child: Text('No transactions added yet!'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final transaction = transactions[index];
            return Card(
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    transaction.date.toString().split('-')[1],
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider(color: const Color.fromARGB(255, 248, 246, 246));
          },
          itemCount: transactions.length,
        );
      },
    );
  }
}
