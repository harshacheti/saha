import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/product_details.dart';
import 'package:saha/pages/searchpage.dart';
import 'package:saha/services/database.dart';

class CategoryDetails extends StatefulWidget {
  final category_details_id;
  final category_details_name;

  //final product_details_new_price;
  // final product_details_old_price;
  // final product_details_picture;

  CategoryDetails({this.category_details_id, this.category_details_name
      // this.product_details_new_price,
      //this.product_details_old_price,
      //this.product_details_picture
      });

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category_details_name),
          elevation: 2.0,
          backgroundColor: Colors.lightBlue[50],
          iconTheme: IconThemeData(color: Colors.blueGrey),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search), onPressed: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) => new SearchBar()));}),
           // new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('category', isEqualTo: widget.category_details_id)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
                // height: 120,
                child: ListView.builder(
                    //scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(2.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot products =
                          snapshot.data.documents[index];
                      if (products.data()["category"] ==
                          widget.category_details_name) {print('lol');}
                      return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .push(new MaterialPageRoute(
                                      builder: (context) => StreamProvider<Users>.value(
                      value: Database().users, child: new ProductDetails(
                                            //passing value of product
                                            product_details_name:
                                                products.data()['title'],
                                            product_details_new_price:
                                                products.data()['totalPrice'],
                                            product_details_old_price:
                                                products.data()['Price'],
                                            product_details_picture:
                                                products.data()['imageURL'],
                                        product_details_description:
                                        products.data()['description'],
                                        product_details_id: products.id,
                                          )))),
                              child: Container(
                                height: 110,
                                //child: Card(
                                //width: 100,
                                // height:100 ,
                                // semanticContainer : true,
                                // elevation: 2,
                                // shape: RoundedRectangleBorder(
                                //    borderRadius: BorderRadius.circular(10.0),
                                //  ),
                                child: ListTile(
                                    contentPadding: EdgeInsets.all(5.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),

                                    //tileColor: Colors.white,
                                    //leading: Container(
                                    // height: 150,
                                    //  width: 100,
                                    //  child: Image.network(
                                    //   products['imageURL'],
                                    //    alignment: Alignment.center,
                                    //  )),
                                    title: Row(children: <Widget>[
                                      Image.network(
                                        products['imageURL'],
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Flexible(
                                          child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            products['title'],
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        true),
                                          ),
                                        )
                                      ]))
                                    ]),
                                    //Text(products['title']),
                                    //subtitle: Divider(thickness: 1,),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("\₹ ${products['price']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                                      //textHeightBehavior:
                                      // TextHeightBehavior(
                                      //     applyHeightToFirstAscent: true),
                                    ) //),
                                    ),
                                //    )
                              )));
                    }));
          },
        ));
  }
}
