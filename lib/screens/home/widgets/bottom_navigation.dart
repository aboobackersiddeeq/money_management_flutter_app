import 'package:flutter/material.dart';
import 'package:money_management/screens/home/home_screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (cxt, updatedIndex, child) =>BottomNavigationBar(
        selectedItemColor: Colors.purple,
        currentIndex: updatedIndex,
        onTap: (newIndex) => HomeScreen.selectedIndexNotifier.value = newIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
            
          ),
        ],
      ), 
    );
  }
}
