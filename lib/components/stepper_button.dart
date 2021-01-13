import 'package:flutter/material.dart';
import 'package:saha/actions/button_color.dart';
import 'package:saha/actions/cart_functions.dart';
import 'package:saha/actions/rough.dart';
import 'package:saha/payment/checkout_screen.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.stepValue,
    @required this.iconSize,
    @required this.value,
    this.product_details_id,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  final product_details_id;
  int value;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  ButtonColor feedPage;
  Widget currentPage;
  int stepValue;

  @override
  void initState() {
    super.initState();
    feedPage = ButtonColor();

    currentPage = feedPage;
  }

  @override
  Widget build(BuildContext context) {
    Widget swapWidget;
    if (widget.value == 0) {
      swapWidget = new ButtonColor();
    }
    else {
      return Container(


          child: Padding( padding: EdgeInsets.only(top:3,left: 3),   child:Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(3),
                child: InkWell(

                  child: Icon(
                      Icons.remove_circle, color: Colors.blue, size: 30),
                  //icon: Icons.remove,
                  onTap: () {
                    setState(() {first();
                      widget.value = widget.value == widget.lowerLimit
                          ? widget.lowerLimit
                          : widget.value -= widget.stepValue;
                    });removeItem(widget.product_details_id,widget.value);
                  },
                ),),
              Container(
                width: widget.iconSize,
                child: Text(
                  '${widget.value}',
                  style: TextStyle(
                    fontSize: widget.iconSize * 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(padding: EdgeInsets.all(3),
                child: InkWell(

                  child: Icon(Icons.add_circle, color: Colors.blue, size: 30,),
                  //icon: Icons.remove,
                  onTap: () {
                    setState(() {first();
                      widget.value = widget.value == widget.upperLimit
                          ? widget.upperLimit
                          : widget.value += widget.stepValue;addItem(widget.product_details_id,widget.value);addIt();first();
                    });
                  },
                ),),

            ],
          )));
    }
    return  Container(child: swapWidget,);
  }
  }




