import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saha/components/products.dart';

import '../main.dart';
import 'home_page.dart';

class ProductDetails extends StatefulWidget {
  final product_details_name;
  final product_details_new_price;
  final product_details_old_price;
  final product_details_picture;
  final product_details_description;
  final product_details_id;

  ProductDetails(
      {this.product_details_name,
      this.product_details_new_price,
      this.product_details_old_price,
      this.product_details_picture,
      this.product_details_description,
      this.product_details_id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.lightBlue[50],
          iconTheme: IconThemeData(color: Colors.blueGrey),
          title: Text(
            'Product',
            style: GoogleFonts.varelaRound(
              color: Color(0xff2A2D31),
              fontWeight: FontWeight.w600,
            ),
          ),
          titleSpacing: -10.0,
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FloatingActionButton.extended(
          elevation: 6,
            shape: RoundedRectangleBorder(
              side:
              BorderSide(color: Colors.blue),
              borderRadius:
              const BorderRadius.all(
                  Radius.circular(100.0)),
            ),
             isExtended: true,
            label: Text("Add to My Cart",style: TextStyle(color: Colors.blue),),
            backgroundColor: Colors.white,
            onPressed: () {})),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[200],
                      Colors.white,
                    ],
                    stops: [0.1, 1],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                // child: Hero(
                //   tag: widget.product_details_id,
                child: Image.network(
                  widget.product_details_picture,
                  height: 300,
                ),
              ),
              // ),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.product_details_name,
                                style: GoogleFonts.varelaRound(
                                  color: Color(0xff2A2D31),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${widget.product_details_old_price}",
                                //widget.product_details_old_price,
                                style: GoogleFonts.varelaRound(
                                  color: Color(0xff2A2D31),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey[200],
                                  Colors.white,
                                ],
                                stops: [0.1, 1],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "${widget.product_details_new_price}",
                              style: GoogleFonts.varelaRound(
                                color: Color(0xff2A2D31),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        widget.product_details_description,
                        style: GoogleFonts.varelaRound(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          'People also buy',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
                        ),
                      ),
                    ),
                    Products(),
                    Container(
                      height: 58,
                    ),


                  ],
                ),
              ),
            ])));
  }
}

class _AvailableColor extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _AvailableColor({
    Key key,
    this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      padding: EdgeInsets.all(isSelected ? 1.5 : 0),
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(
                color: Color(0xff2A2D31),
              ),
              shape: BoxShape.circle,
            )
          : BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

//Container(
//height: 340.0,
//child: Similar_product(),
//)

class Similar_product extends StatefulWidget {
  @override
  _Similar_productState createState() => _Similar_productState();
}

class _Similar_productState extends State<Similar_product> {
  var product_list = [
    {
      "name": "Ladies Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 5000,
      "price": 3500,
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 3000,
      "price": 2000,
    },
    {
      "name": " Black Hills",
      "picture": "images/products/hills1.jpeg",
      "old_price": 1800,
      "price": 1200,
    },
    {
      "name": "Hills",
      "picture": "images/products/hills2.jpeg",
      "old_price": 1500,
      "price": 1000,
    },
    {
      "name": "Gabadig Pants",
      "picture": "images/products/pants1.jpg",
      "old_price": 800,
      "price": 500,
    },
    {
      "name": "Pants",
      "picture": "images/products/pants2.jpeg",
      "old_price": 1200,
      "price": 650,
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "old_price": 1700,
      "price": 1200,
    },
    {
      "name": "Skirt",
      "picture": "images/products/skt1.jpeg",
      "old_price": 2600,
      "price": 1850,
    },
    {
      "name": "Skirts",
      "picture": "images/products/skt2.jpeg",
      "old_price": 2399,
      "price": 1999,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Similar_single_prod(
              prod_name: product_list[index]['name'],
              prod_pricture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        //passing value of product
                        product_details_name: prod_name,
                        product_details_new_price: prod_price,
                        product_details_old_price: prod_old_price,
                        product_details_picture: prod_pricture,
                      ))),
              child: GridTile(
                  footer: Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                              prod_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                          new Text(
                            "\Tk ${prod_price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )
                        ],
                      )),
                  child: Image.asset(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
