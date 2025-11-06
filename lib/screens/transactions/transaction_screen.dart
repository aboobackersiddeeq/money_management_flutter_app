import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return const Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Text('12\nMar',textAlign:TextAlign.center,)),
            title: Text("10000"),
            subtitle: Text("Travel"),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return Divider(color: const Color.fromARGB(255, 248, 246, 246));
      },
      itemCount: 10,
    );
  }
}
