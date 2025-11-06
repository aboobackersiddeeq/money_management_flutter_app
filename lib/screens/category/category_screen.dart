import 'package:flutter/material.dart';
import 'package:money_management/screens/category/expense_category_list.dart';
import 'package:money_management/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      // initialIndex: 0,
      // animationDuration: Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "INCOME"),
            Tab(text: "EXPENSE"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [IncomeCategoryList(), ExpenseCategoryList()],
          ),
        ),
      ],
    );
  }
}
