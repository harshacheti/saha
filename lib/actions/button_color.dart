import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/rough.dart';
import 'package:saha/components/stepper_button.dart';
import 'package:saha/models/user.dart';
import 'cart_functions.dart';
import 'package:saha/payment/checkout_screen.dart';

class ButtonColor extends StatefulWidget {
  final product_details_id;

  const ButtonColor({this.product_details_id});

  @override
  _ButtonColorState createState() => _ButtonColorState();
}

class _ButtonColorState extends State<ButtonColor> {

  bool pressAttention = false;
  bool swap = false;

  @override
  Widget build(BuildContext context) {
    var userList = Provider.of<Users>(context);
    print(userList);
    if (userList == null) {
      return CircularProgressIndicator();
    }
    else {
      var lam = deSerializeItems(userList.cart);
      var idx = lam.indexWhere((item) =>
      item['id'] == widget.product_details_id);
      //print(idx);
      Widget swapWidget;
      if (idx != -1) {
        swapWidget = new CustomStepper(
          lowerLimit: 0,
          upperLimit: 20,
          stepValue: 1,
          iconSize: 15.0,
          value: lam[idx]['quantity'],
          product_details_id: widget.product_details_id,
        );
      }
      else {
        ButtonTheme(

            height: 30,

            child:
            swapWidget = new RaisedButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              ),
              padding: const EdgeInsets.all(2.0),
              textColor: //pressAttention ? Colors.white :
              Colors.blue,
              color: //pressAttention ? Colors.blue :
              Colors.white,
              onPressed: () {
                first(userList.cart);
                setState(() {
                  first(userList.cart);
                  swap = !swap;
                  first(userList.cart);
                });
                addItem(widget.product_details_id, 1);
                //CheckoutScreen();
                addIt();
                first(userList.cart);
              },
              child:
              new Text(
                "Add to Cart",
                style: TextStyle(fontSize: 12),
              ),
            ));
      }

      return Container(child: swapWidget,);
    }
  }
}
