import 'package:flutter/material.dart';
import 'package:saha/components/categories_vertical_list_view.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
      elevation: 0.0,
      backgroundColor: Colors.lightBlue[50],
      title: Text('Shopping Cart'),
      actions: <Widget>[
        new IconButton(
            icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
      ],
    ),
      body: CategoryVerticalListView(),
    );
  }
}
