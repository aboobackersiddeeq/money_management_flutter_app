import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        TextFormField(decoration: InputDecoration(hintText: 'Name'),),
        TextFormField(decoration: InputDecoration(hintText: 'Price'),),
        TextFormField(decoration: InputDecoration(hintText: 'Category'),),
        ElevatedButton(onPressed: (){}, child: Text("Add"))
      ],
    )
    );
  }
}