import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saha/actions/cart_functions.dart';

var tom;
//var list=new List();
item(sam) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((d) {
    var doc = d.data();
    //print(doc['cart']);
    var items = deSerializeItems(doc['cart']);

    //print(lol);
    return items;
  }).then((lol) {
    lol.forEach((masa) {
      FirebaseFirestore.instance
          .collection("products")
          .doc(masa['id'])
          .get()
          .then((value) {
        // print(value.data());
        sam(value.data());

        //list.add(value.data());
        // print(list);
      });
    });
  });
}
main() {
  const twentyMillis = const Duration(milliseconds: 1);
  new Timer(twentyMillis, () => CheckoutScreen());
}

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isPaymentComplete = false;
  Razorpay _razorpay = Razorpay();
  var list = new List();

  // var product_on_the_cart = [item()];

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    future();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _openRazorpay() async {
    var options = {
      'key': 'rzp_test_lxD9jsRSbpBOAz',
      // 'order_id': orderId, -> Pass order id by calling Razorpay Order API from backend
      'amount': (200 * 100),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body:_cartScreen(),

      bottomNavigationBar: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total amount: ₹200',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                //setState(() {
                 // future() ;
                 // print(list.length);
              //  });
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

  sam(obj) {
    list.add(obj);
  }

  Future future() async {
    await item(sam);
  }

  _cartScreen(){
    return ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                        // ignore: missing_return
                          builder: (context) {})),
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
                            list[index]['imageURL'],
                            alignment: Alignment.centerLeft,
                          ),
                          Flexible(
                              child: Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    list[index]['title'],
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: true),
                                  ),
                                )
                              ]))
                        ]),
                        //Text(products['title']),
                        //subtitle: Divider(thickness: 1,),
                        trailing: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("\₹ ${list[index]['price']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                          //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                          //textHeightBehavior:
                          // TextHeightBehavior(
                          //     applyHeightToFirstAscent: true),
                        ) //),
                    ),
                    //    )
                  ))
            // ignore: missing_return
          );
        }
    );
  }


}
