import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saha/actions/button_color.dart';
import 'package:saha/actions/cart_functions.dart';
import 'package:saha/actions/payment_actions.dart';
import 'package:saha/models/orders.dart';
import 'package:saha/models/products_stream.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/appbar&bottom_nav.dart';
import 'package:saha/pages/home_page.dart';
import 'package:saha/services/database.dart';

class CheckoutScreen extends StatefulWidget {

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();

}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isPaymentComplete = false;
  bool isLoading = false;
  Razorpay _razorpay = Razorpay();
  final _formKey = GlobalKey<FormState>();

  //var chat = [];
  final chat = [];
  var cha = [];
  var items;
  var lolPrice;
  int res ;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  _showModalBottomSheet(context,f,products) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              top: true,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Container(
                      //height: 50,
                      color: Color(0xFF737373),
                      child: Container(
                          // height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 50.0,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    child: Title(
                                        color: Colors.black,
                                        child: Text('Enter Delivery Address'))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    child: new Theme(
                                        data: new ThemeData(
                                          primaryColor: Colors.redAccent,
                                          primaryColorDark: Colors.red,
                                        ),
                                        child: TextFormField(
                                          maxLines: 2,
                                          cursorColor: Colors.red,
                                          controller: addressController,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.map),
                                            fillColor: Colors.red,
                                            hoverColor: Colors.red,
                                            labelText: "Enter Address",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter Address';
                                            }
                                            return null;
                                          },
                                        ))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    child: new Theme(
                                        data: new ThemeData(
                                          primaryColor: Colors.redAccent,
                                          primaryColorDark: Colors.red,
                                        ),
                                        child: TextFormField(
                                          maxLines: 1,
                                          cursorColor: Colors.red,
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.map),
                                            fillColor: Colors.red,
                                            hoverColor: Colors.red,
                                            labelText: "Enter Phone Number",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter Phone Number';
                                            } else if (value.length != 10) {
                                              return 'Please enter a valid Phone Number';
                                            }
                                            return null;
                                          },
                                        ))),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 20, right: 20, top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  makeOnlinePayRequest(addressController.text,phoneController.text,f,products);
                                                  isLoading = true;
                                                });
                                                _openRazorpay();
                                              }
                                            },
                                            child: Text('Online Payment'),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RaisedButton(
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              makeCodRequest(addressController.text,phoneController.text,f,products);
                                              setState(() {
                                                isLoading = true;
                                              });
                                              return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text(
                                                      "Order Placed Successfully"),
                                                  content: Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.green,
                                                    size: 48,
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () {

                                                        Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            //builder: (context) => new ProfileScreen(detailsUser: details),
                                                            builder: (context) =>  AppbarBottomNav(), //new HVhome(detailsUser: details),
                                                          ),
                                                        );
                                                      },
                                                      child: Text("okay"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Cash on Delivery'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]))))));
        });
  }

  _listenToData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((snap) {
     var i = deSerializeItems(snap.data()['cart']);
      i.forEach((d) {
        FirebaseFirestore.instance
            .collection("products")
            .doc(d['id'])
            .get()
            .then((value) {
         // chat.add(value);
        });
      });
    });
  }

  calcTPriceC() {
   return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
        //  chat.clear();
          if (snapshot.hasData) {
            // print(snapshot.data['cart']);

            var k = deSerializeItems(snapshot.data['cart']);
          k.forEach((item) {
              FirebaseFirestore.instance
                  .collection("products")
                  .doc(item['id'])
                  .get()
                  .then((d) {
                //print(d.data());
                final data = d.data();
                chat.add(data);
               // print(chat);
                return chat;
              });
         });
            FirebaseFirestore.instance
                .collection("products")
                .get().then((d) {
              d.docs.forEach((i) {
               // print(i.id);
                  var idx = k.indexWhere((item) => item['id'] == i.id);
                  if(idx!=-1){
                     res = res + (i['totalPrice'] * k[idx]['quantity']);}

              });
            });

        //    print(chat);

            return Text(
              'Total Amount:' + res.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });

   /// chat.forEach((i) {
   ///  var idx = items.indexWhere((item) => item['id'] == i.id);
   ///    res = res + (i['totalPrice'] * items[idx]['quantity']);
   ///  });
   ///  return res;
  }

  @override
  void initState() {
    super.initState();
    _listenToData();

    calcTPriceC();

    // clen();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
       // res = 0;
        calcTPriceC();
      });
    });
    // initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  buildAllAds() {
    if (chat.length == 0) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
          itemCount: chat.length,
          itemBuilder: (context, index) {
          //  print(chat.length);
            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StreamProvider<Users>.value(
                                value: Database().users,
                                child: CheckoutScreen()))),
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
                        trailing: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("\₹ ${chat[index]['totalPrice']}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                          //textHeightBehavior:
                          // TextHeightBehavior(
                          //     applyHeightToFirstAscent: true),
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
                            chat[index]['imageURL'],
                            alignment: Alignment.centerLeft,
                          ),
                          Flexible(
                              child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                chat[index]['title'],
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: true),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StreamProvider<Users>.value(
                                                  value: Database().users,
                                                  child: CheckoutScreen()))),
                                  child: ButtonColor(
                                    product_details_id: chat[index].id,
                                  ),
                                )),
                          ])),
                        ]),
                        //Text(products['title']),
                        //),
                      ),
                      //    )
                    ))

                // ignore: missing_return
                );
          }
          //  );*/
          //  },
          );
      // Container(
      //    height: 0,
      //    width: 0,
      //    child: loveda());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
    //list.clear();
  }

  void _openRazorpay() async {
    var options = {
      'key': 'rzp_test_lxD9jsRSbpBOAz',
      // 'order_id': orderId, -> Pass order id by calling Razorpay Order API from backend
      'amount': (calcTPriceC() * 100),
      'name': 'Razorpay Inc.',
      'description': 'Thank you for shopping with us!',
      // 'prefill': {'contact': '2783939294', 'email': 'abc@gmail.com'}, -> pass contact and email details of the user if available
      'theme': {
        'color': '#008000',
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showPaymentPopupMessage(context, true, 'Payment Successful!');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPaymentPopupMessage(context, false, 'Payment Failed!');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(
        'You have chosen to pay via : ${response.walletName}. It will take some time to reflect your payment.');
  }

  void showPaymentPopupMessage(
      BuildContext ctx, bool isPaymentSuccess, String message) {
    showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              isPaymentSuccess
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
              SizedBox(
                width: 5,
              ),
              Text(
                isPaymentSuccess ? 'Payment Successful' : 'Payment Failed',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(message),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> bookList = Provider.of<List<Product>>(context);
    var userList = Provider.of<Users>(context);
    var f = deSerializeItems(userList.cart);
   //print(bookList.first.);

    //print(Orders );

   // print(deSerializeItems(userList.cart));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('My Cart'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new AppbarBottomNav()),
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var jam = 0;
          if (snapshot.hasData) {
           // print(snapshot.data['cart']);
            var k = deSerializeItems(snapshot.data['cart']);
            List l = loadCartItems(k);
            //print(l.length);
            return ListView.builder(
                itemCount: k.length,
                itemBuilder: (context, index) {
                  // FirebaseFirestore.instance
                  //   .collection("products")
                  //  .doc(k[index]['id'])
                  //   .get()
                  //    .then((value) {
                  //   cha.add(value);
                  //  });
                  // print(cha.length);
                  return
                      //StreamBuilder(stream: ,builder: null)

                      StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .doc(k[index]['id'])
                        .snapshots(),
                    builder: (context, snap) {
                      if (snapshot.hasData) {

                        // print(k[index]['id']);
                        //chat.forEach((i) {
                        //   var idx = items.indexWhere((item) => item['id'] == i.id);
                        //  res = res + (i['totalPrice'] * items[idx]['quantity']);
                        //  });
                        //  return res;
                        return //Text(snap.data['title']);
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: //InkWell(
                                    // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                    // ignore: missing_return
                                    // builder: (context) {})),
                                   // child:
                              Container(
                                  height: 110,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(5.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                          "\₹ ${snap.data['totalPrice']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    title: Row(children: <Widget>[
                                      Image.network(
                                        snap.data['imageURL'],
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Flexible(
                                          child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            snap.data['title'],
                                            softWrap: true,
                                            maxLines: 3,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        true),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 60.0),
                                          child: ButtonColor(
                                            product_details_id: snap.data.id,
                                          ),
                                        ),
                                      ])),
                                    ]),
                                    //Text(products['title']),
                                    //),
                                  ),
                                  //    )
                                ));

                                // ignore: missing_return
                               // );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }, //Text(k[index]['id'].toString()),
                  );
                }); //StreamBuilder(stream: ,builder: )
          } else {
            return CircularProgressIndicator();
          }
        },
      )
      /* GestureDetector(
        onTap:() =>
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => StreamProvider<Users>.value(
                value: Database().users, child:CheckoutScreen()))),
      child: ListView.builder(
          itemCount: chat.length,

          itemBuilder: (context, index) {
            print(chat.length);
            return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                   // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      // ignore: missing_return
                       // builder: (context) {})),
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
                        trailing: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("\₹ ${chat[index]['totalPrice']}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                          //textHeightBehavior:
                          // TextHeightBehavior(
                          //     applyHeightToFirstAscent: true),
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
                            chat[index]['imageURL'],
                            alignment: Alignment.centerLeft,
                          ),
                          Flexible(
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    chat[index]['title'],
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: true),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: ButtonColor(
                                    product_details_id: chat[index].id,
                                  ),
                                ),
                              ])
                          ),


                        ]),
                        //Text(products['title']),
                        //),
                      ),
                      //    )
                    ))

              // ignore: missing_return
            );
          }
        //  );
        //  },
      ),
      )*/
      ,

      //_cartScreen()
      // new GestureDetector(
      // onTap: () {
      // chat.clear();
      // Change the color of the container beneath
      // setState(() {

      //   calcTPrice();
      //  });
      //},
      //child:
      //buildAllAds(),
      //),
      bottomNavigationBar: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            calcTPriceC(),
            loveDa(),
            RawMaterialButton(
              onPressed: () {
                _showModalBottomSheet(context,f,bookList);
                // _openRazorpay();
                //CartLoading();
                //  setState(() {
                //future() ;
                //  print(list.length);
                //   });
              },
              //_openRazorpay(),
              child: Text(
                'CHECKOUT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.zero,
            ),

          ],
        ),
      ),
    );
  }

loveDa() {chat.clear();items=''; res=0 ;return Padding(padding:EdgeInsets.all(0));}
}
