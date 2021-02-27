import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saha/actions/cart_functions.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
              padding: EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: color != null ? color : Colors.lightBlueAccent,
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var k = deSerializeItems(snapshot.data['cart']);
                    return Text(k.length.toString(),textAlign: TextAlign.center,
                      style: TextStyle(
                       fontSize: 10,
                      color: Colors.white
                      ),);
                  } else {
                    return Text('0');
                  }
                },
              )

              //Text(
              //  value,
              //  textAlign: TextAlign.center,
              //  style: TextStyle(
              //    fontSize: 10,
              //   color: Colors.white
              //  ),
              // ),
              ),
        )
      ],
    );
  }
}
