import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_modal.dart';
import 'package:money_management/screens/transactions/widgets/date_input_field.dart';

//  Purpose Date Amount Income/Expense CategoryType
class TransactionAddScreen extends StatefulWidget {
  const TransactionAddScreen({super.key});

  @override
  State<TransactionAddScreen> createState() => _TransactionAddScreenState();
}

class _TransactionAddScreenState extends State<TransactionAddScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  CategoryType? selectedType = CategoryType.income;
  // Example categories
  List<CategoryModal> _categories = [];

  String? selectedCategory;
  CategoryModal? selectedCategoryModal;
  @override
  void initState() {
    super.initState();
    _loadCategories(selectedType!); //selectedType initial load
  }

  // get categories
  Future<void> _loadCategories(CategoryType type) async {
    final value = await CategoryDb().getAllCategories(type);
    setState(() {
      _categories = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Form(
            key: formKey,
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Purpose
                const Text(
                  ' Purpose',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    hintText: 'Purpose',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? "Enter your purpose"
                      : null,
                ),

                // Amount
                const Text(
                  ' Amount',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? "Enter your amount"
                      : null,
                ),

                // Date
                const Text(
                  '  Date',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DateInputField(controller: _dateController),

                // Type
                const Text(
                  '  Type',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioGroup<CategoryType>(
                  groupValue: selectedType,

                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                      selectedCategory = null;
                    });
                    _loadCategories(value!);
                  },

                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<CategoryType>(
                          title: const Text('Income'),
                          value: CategoryType.income,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<CategoryType>(
                          title: const Text('Expense'),
                          value: CategoryType.expense,
                        ),
                      ),
                    ],
                  ),
                ),

                // Dropdown category
                const Text(
                  '  Category',
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 8, 8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? "Select category"
                      : null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Category',
                  ),
                  items: _categories
                      .map(
                        (val) => DropdownMenuItem<String>(
                          value: val.id?.toString(),
                          child: Text(val.name),
                          onTap: () {
                            setState(() {
                              selectedCategoryModal = val;
                            });
                          },
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            selectedType != null) {
                          final parsedAmount = double.tryParse(
                            _amountController.text,
                          );
                          final parsedDate = DateTime.parse(
                            _dateController.text,
                          );
                          if (parsedAmount == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter correct amount'),
                              ),
                            );
                            return;
                          }

                          final _newTransaction = TransactionModal(
                            purpose: _purposeController.text,
                            amount: parsedAmount,
                            date: parsedDate,
                            type: selectedType!,
                            category: selectedCategoryModal!,
                          );

                          TransactionDb.instance.insertTransaction(_newTransaction);
                        }
                      },
                      child: Text("ADD"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
