import 'package:flutter/material.dart';
import 'package:money_management/screens/category/category_add_popup.dart';
import 'package:money_management/screens/category/category_screen.dart';
import 'package:money_management/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management/screens/transactions/transaction_add_screen.dart';
import 'package:money_management/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [TransactionScreen(), CategoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Money Manager"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx1) => TransactionAddScreen()));
          } else {
            showCategoryPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
