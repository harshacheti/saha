import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saha/actions/cart_functions.dart';
import 'package:saha/models/orders.dart';
import 'package:saha/models/products_stream.dart';
import 'package:saha/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> get products {
    return _firestore
        .collection("products")
        .snapshots()
        .map((event) =>
        event.docs
            .map((DocumentSnapshot snapshot) =>
            Product(
              name: snapshot.data()['title'],
              productId: snapshot.id,
              productCategory: snapshot.data()['category'],
              productDescription: snapshot.data()['description'],
              productImg: snapshot.data()['imageURL'],
              productUnits: snapshot.data()['unit'],
              productDiscount: snapshot.data()['discount'],
              productPrice: snapshot.data()['price'],
              productTax: snapshot.data()['taxedPrice'],
              productTotalPrice: snapshot.data()['totalPrice'],
              productVisibility: snapshot.data()['visibility'],
              productSpecial: snapshot.data()['special'],
            ))
            .toList());
  }

  Stream<Users> get users {
    return _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) =>
        Users(
          cart: snapshot.data()['cart'],
        ));
  }

  //Stream<Orders> get orders {
  //  return _firestore.collection('users').doc(
   //     FirebaseAuth.instance.currentUser.uid).get().then((e) => var k =
   //     deSerializeItems(e); ;
  //}
}
