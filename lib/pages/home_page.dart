import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/payment_actions.dart';
import 'package:saha/components/category_list_view.dart';
import 'package:saha/components/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saha/models/products_stream.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/searchpage.dart';
import 'package:saha/pages/signup.dart';
import 'package:saha/payment/checkout_screen.dart';
import 'package:saha/services/database.dart';

import 'categories_page.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({this.uid, this.title});
  final String uid;
  final String title;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final User user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser.displayName;

 var _pages = <Widget>[
    MyHomePage(),//this is a stateful widget on a separate file
   CategoriesPage(),//this is a stateful widget on a separate file
    //School(),//this is a stateful widget on a separate file
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> bookList = Provider.of<List<Product>>(context);
   // bookList.forEach((e) {print(e);});
  //print(bookList.last.name);
    //print(bookList.last.productId);

    //gives the current user doc id
    print(user.uid);
    Widget imageCarousel = new Container(
      height: 200.0,

      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/c1.jpg'),
          AssetImage('assets/images/c2.jpg'),
          AssetImage('assets/images/c2.jpg'),
          AssetImage('assets/images/c1.jpg'),
          AssetImage('assets/images/c1.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );

    return Scaffold(

      body:
      //_pages.elementAt(_currentIndex),
      new ListView(
        children: <Widget>[
          imageCarousel,
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Categories',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          //horizontal list view
          CategoryListView(),
         // Divider(),
          //recent product
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Recent Post',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),

          //grid view
          //SizedBox(child: Products(),height: MediaQuery.of(context).size.height*0.5,),
          Products(),

          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'New Products',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          Products(),
          //Divider(),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Trending',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          Products(),
          //Divider(),
        ],
      ),
    );
  }
}