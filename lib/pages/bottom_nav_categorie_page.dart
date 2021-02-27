import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'category_listview_page.dart';

class BottomNavCategoriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // appBar: AppBar(
       //   title: Text("categories"),
        //  elevation: 2.0,
        //  backgroundColor: Colors.lightBlue[50],
        //  iconTheme: IconThemeData(color: Colors.blueGrey),
        //  actions: <Widget>[
        //    new IconButton(icon: Icon(Icons.search), onPressed: () {Navigator.push(
        //        context, MaterialPageRoute(builder: (context) => new SearchBar()));}),
            // new IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        //  ],
       // ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('categories').snapshots(),
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
                      //if (products.data()["category"] ==
                      //    widget.category_details_name) {print('lol');}
                      return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (context) => new CategoryDetails(
                                        //passing value of product
                                        category_details_id: products.id,
                                        category_details_name:
                                        products.data()['title'],
                                        // product_details_new_price: products.data()['totalPrice'],
                                        // product_details_old_price: products.data()['Price'],
                                        // product_details_picture: products.data()['imageURL'],
                                      ))),

                              child: Container(
                                height: 110,
                                child: ListTile(
                                    contentPadding: EdgeInsets.all(5.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
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
                                ),
                                //    )
                              )));
                    }));
          },
        ));
  }
}