import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:saha/components/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//class Products{
 // String category;
 // String description;

 // Products.fromMap(Map<String, dynamic> data){
 //   category = data['category'];
 //   description= data['description'];
 // }
//}

class DatabaseManager {



  final CollectionReference productname =
      FirebaseFirestore.instance.collection('products');



  Future getProductData() async {
    List itemsList = [];

    try {
      await productname.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;

    } catch (e) {
      print(e.toString());
      return null;
    }



  }



}
