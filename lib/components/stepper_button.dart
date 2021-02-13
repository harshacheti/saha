import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/button_color.dart';
import 'package:saha/actions/cart_functions.dart';
import 'package:saha/actions/rough.dart';
import 'package:saha/models/user.dart';
import 'package:saha/payment/checkout_screen.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.stepValue,
    @required this.iconSize,
    @required this.value,
    @required this.product_details_id,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  var product_details_id;
  var value;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  ButtonColor feedPage;
  Widget currentPage;
  int stepValue;
  var value;

  @override
  void initState() {
    super.initState();
    feedPage = ButtonColor();
    currentPage = feedPage;
  }

  @override
  Widget build(BuildContext context) {
    var userList = Provider.of<Users>(context);
    Widget swapWidget;
    if (value == 0) {
      swapWidget = new ButtonColor();
    } else {
      return Padding(padding: EdgeInsets.only(right: 0,top: 7),
        child:Container(
        //color: Colors.pink,
        //alignment: AlignmentDirectional.center,

          child: Wrap(
              //crossAxisAlignment: WrapCrossAlignment.center,
         // child: Padding(
           //   padding: EdgeInsets.only(top: 3, left: 3),
             // child: Row(
             //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:
                  Padding(

                    padding: EdgeInsets.only(right: 0,top: 0),
                    child: InkWell(
                      child: Icon(Icons.remove_circle,
                          color: Colors.blue, size: 30),
                      //icon: Icons.remove,
                      onTap: () {
                        first(userList.cart);
                        setState(() {
                          first(userList.cart);
                          removeItem(widget.product_details_id, value);
                          var lam = deSerializeItems(userList.cart);
                          var idx = lam.indexWhere((item) =>
                              item['id'] == widget.product_details_id);
                          value = value == widget.lowerLimit
                              ? widget.lowerLimit
                              : lam[idx][
                                  'quantity']; //widget.value -= widget.stepValue;
                        }); //removeItem(widget.product_details_id,widget.value);
                        first(userList.cart);
                      },
                    ),
                  ),),
                //Transform(
            //  transform: new Matrix4.identity()..scale(0.7 ),
              // child:
              //Container(
              //  width: widget.iconSize,
              //child:
              Expanded(

                   // alignment: hor,
                  //  width: widget.iconSize,
                    child: Text(
                      widget.value.toString(),
                      style: TextStyle(
                        fontSize: widget.iconSize * 0.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
    //),
    //),
              Expanded(

                child:

              Padding(
                    padding: EdgeInsets.only(left: 0,top: 0),
                    child: InkWell(
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                        size: 30,
                      ),
                      //icon: Icons.remove,
                      onTap: () {
                        first(userList.cart);
                        setState(() {
                          first(userList.cart);
                          addItem(widget.product_details_id, value);
                          var lam = deSerializeItems(userList.cart);
                          var idx = lam.indexWhere((item) =>
                              item['id'] == widget.product_details_id);
                          value = value == widget.upperLimit
                              ? widget.upperLimit
                              : lam[idx][
                                  'quantity']; //widget.value += widget.stepValue;
                          //addItem(widget.product_details_id,widget.value);
                          //addIt();
                          first(userList.cart);
                        });
                        first(userList.cart);
                      },
                    ),
                  ),
              )
                ],)]
              )))
    //)
    ;
    }
    return Container(
      child: swapWidget,
    );
  }
}
