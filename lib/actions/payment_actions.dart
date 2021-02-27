import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:saha/models/orders.dart';

var chat=[] ;
User result = FirebaseAuth.instance.currentUser;

makeCodRequest(address, ph, f, products) async {

 // chat = ['a'] ;

  products.forEach((i) {
    var idx = f.indexWhere((item) => item['id'] == i.productId);
    if(idx!=-1){

      chat.add('${i.name}'+";"+"${f[idx]['quantity']}"+";"+"${i.productTotalPrice}"+";"+"${i.productUnits}");
    }

    });
  //print(chat.toString());
  var items= getItems(chat);
print(items);
  var amount = calcTPrice(items);
  print(amount);

  String url =
      'https://us-central1-suryakantham-cde7f.cloudfunctions.net/payment/create_order';
  var headers = {"Content-type": "application/json"};
  // Map<String, String> headers = {
  // "Content-Type": "application/json"
  //};
  Map<String, dynamic> body =
  {"amount": amount,
    "order_data": chat.toString(),
    "user_id": result.uid,
    "user_name": result.displayName,
    "delivery": address,
    "pincode": "400909",
    "pnum": ph,
    "cod": true};
  // make POST request
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  Response response = await post(
    url, headers: headers, body: jsonBody, encoding: encoding,);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String ans = response.body;
  print(statusCode);
  print(ans);
  print(jsonBody);
  print(encoding);
  chat.clear();
}

makeOnlinePayRequest(address, ph, f, products) async {
  // set up POST request arguments

  products.forEach((i) {
    var idx = f.indexWhere((item) => item['id'] == i.productId);
    if(idx!=-1){

      chat.add('${i.name}'+";"+"${f[idx]['quantity']}"+";"+"${i.productTotalPrice}"+";"+"${i.productUnits}");
    }

  });
  //print(chat.toString());
  var items= getItems(chat);
  print(items);
  var amount = calcTPrice(items);


  String url =
      'https://us-central1-suryakantham-cde7f.cloudfunctions.net/payment/create_order';
  var headers = {"Content-type": "application/json"};
  // Map<String, String> headers = {
  // "Content-Type": "application/json"
  //};
  Map<String, dynamic> body =
  {"amount": amount,
    "order_data": chat.toString(),
    "user_id": result.uid,
    "user_name": result.displayName,
    "delivery": result.uid,
    "pincode": address,
    "pnum": ph,
    "cod": false};
  // make POST request
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  Response response = await post(
    url, headers: headers, body: jsonBody, encoding: encoding,);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String ans = response.body;
  print(statusCode);
  print(ans);
  print(jsonBody);
  print(encoding);
}

calcTPrice(items) {
  if (items.length == 0) {
    return 0;
  }
  else {
    var res = 0;
    items.forEach((i) {
      res = res + (i['quantity'] * i['price']);
    });
    return res;
  }
}

serializeItems(items) {
  var cart = [];

  items.forEach((item) {
    cart.add(
        item.title + ";" + item.quantity + ";" + item.totalPrice + ";" + item.unit
    );
  });
  return cart.join(",");
}


cancelOrder(orderID) {
//return (dispatch, getState, { getFirebase, getFirestore }) => {

  FirebaseFirestore.instance
      .collection("orders")
      .doc(orderID)
      .update({
    'cancelled': true,
//})
    // .then(() => {
//dispatch({ type: "CANCEL_SUCCESS", orderID: orderID });
//})
    // .catch((err) => {
//dispatch({ type: "CANCEL_ERR", err: err });
//});
  });
}

getItems(cart) {
  var items = [];
  if (cart == '') {
    return items;
  }
  else {
    var citems = cart;
    citems.forEach((c) {
      var sc = c.split(";");
      if (sc.length == 4)
        items.add({
          'name': sc[0],
          'quantity': int.parse(sc[1]),
          'price': int.parse(sc[2]),
          'variant': sc[3],
        });
    });
    return items;
  }
}

getItemsCount(cart) {
  return cart
      .split(",")
      .length;
}