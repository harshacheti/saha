import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:saha/components/category_list_view.dart';
import 'package:saha/components/products.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

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

  @override
  Widget build(BuildContext context) {
    return Container();
      /*Scaffold(
      body: ListView(
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
    ));*/
 }
}
