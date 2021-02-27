import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saha/actions/payment_actions.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlue[50],
        title: Text('Orders'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
        ],
      ),
      body: // SingleChildScrollView(
          // child:
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('user_id', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {

                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var chai=snapshot.data.documents[index]
                          .data()['cart'];

                    //  var cat=snapshot.data.documents[index];
                     // var cartIteams= cat['cart'].split(',').split(';');
                     // print(cat);
                    //  var items;
                    //  if (cartIteams.length == 4)
                   //     items.add({
                    //      'name': cartIteams[0],
                    //      'quantity': int.parse(cartIteams[1]),
                    //      'price': cartIteams[2],
                   //       'variant': cartIteams[3],
                   //     });
                   //   print(items);
                      //print(cartIteams[index]['name']);
                      //  return ListView.builder(
                      //   itemCount: snapshot.data.documents[index]
                      //      .data()['cart']
                      //      .split(",")
                      //      .length,
                      //   itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: Material(
                          elevation: 20,
                          child: Container(
                              //padding: EdgeInsets.all(20),
                              height: 200,
                              child: Column(children: <Widget>[
                                // Text('Order Status'),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(9),
                                    child: Row(
                                    children: <Widget>[ Expanded(
                                      child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Column(children: <Widget>[
                                              Text(
                                                "Order Status",
                                                textAlign: TextAlign.left,
                                              ),
                                              if (snapshot.data.documents[index]
                                                      .data()['deliverd'] ==
                                                  false)
                                                Text((() {
                                                  if (snapshot.data.documents[index]
                                                          .data()['deliverd'] ==
                                                      false) {
                                                    return "Shipping";
                                                  }

                                                  return "Delivered";
                                                })())
                                            ])),
                                    ),

                                      Expanded(child: Align(alignment: Alignment.topRight,child:Column(children: <Widget>[ Text('Order Total'),Text(snapshot.data.documents[index]
                                          .data()['amount'].toString())]))

                                      )]),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: //Text(getItems(chai)[index]['name']),
                                  ListView.builder(
                                    itemCount: snapshot.data.documents[index]
                                        .data()['cart']
                                        .split(",")
                                        .length,

                                    itemBuilder: (context, index) {

                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(getItems(chai)[index]['name']),
                                      );
                                    },
                                  ),
                                )
                                //  ListView.builder(
                                //    itemCount: snapshot.data.documents[index]
                                //       .data()['cart']
                                //       .split(",")
                                //       .length,
                                //   itemBuilder: (context, index) {
                                //    return Container(
                                //      padding: EdgeInsets.all(20),
                                //       child: Text('lol'),
                                //   );
                                //  },
                                //   ),
                              ])),
                        ),
                      );
                    });
              }),
    );
    //);
    //  }),
    // );
  }
}
