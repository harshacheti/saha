import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saha/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saha/databaseManager/databaseManager.dart';

import 'design_course_app_theme.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        return Container(
            height: 195,


            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                // physics: ClampingScrollPhysics(),
                //padding: const EdgeInsets.all(5.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot products = snapshot.data.documents[index];
                  return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                          onTap: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                        //passing value of product
                                        product_details_name:
                                            products.data()['title'],
                                        product_details_new_price:
                                            products.data()['totalPrice'],
                                        product_details_old_price:
                                            products.data()['Price'],
                                        product_details_picture:
                                            products.data()['imageURL'],
                                      ))),
                          child: Container(
                            width: 110,
                            child: ListTile(
                                contentPadding: EdgeInsets.all(5.0),
                                title: Image.network(products['imageURL']),
                                subtitle: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(children: <Widget>[
                                      Text(
                                        products['title'],
                                        textAlign: TextAlign.center,
                                        style: DesignCourseAppTheme.subtitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: true),
                                      ),

                                      ButtonTheme(
                                      height: 30 ,
                                     child: RaisedButton(

                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.blue),
                                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                        ),
                                          padding: const EdgeInsets.all(2.0),
                                          textColor: Colors.blue,
                                          color: Colors.white,

                                          onPressed: () {},
                                          child: new Text("Add to Cart",style: TextStyle(fontSize: 12),),
                                        ),


                                      //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                                      //textHeightBehavior:
                                      // TextHeightBehavior(
                                      //     applyHeightToFirstAscent: true),
                                      )])
                                    //),
                                    )),
                          )));
                }));
      },
    );
  }

//  @override
// Widget build(BuildContext context) {

//return GridView.builder(
//    itemCount: userProfileList.length,
//   gridDelegate:
//      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//   itemBuilder: (BuildContext context, int index) {
//   return Padding(
//    padding: const EdgeInsets.all(4.0),
//   child: Single_prod(
//       prod_name: userProfileList[index]['category'],
//    prod_pricture: product_list[index]['picture'],
//     prod_old_price: product_list[index]['old_price'],
//     prod_price: product_list[index]['price'],
//    ),
//   );
//   });
// }
}

//class Single_prod extends StatelessWidget {
// final prod_name;
// final prod_pricture;
//final prod_old_price;
//final prod_price;

// Single_prod({
//  this.prod_name,
//  this.prod_pricture,
//  this.prod_old_price,
//  this.prod_price,
// });

//@override
// Widget build(BuildContext context) {
//  return Card(
//   child: Hero(
//       tag: new Text("Saad"),
//      child: Material(
//       child: InkWell(
//         onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//            builder: (context) => new ProductDetails(
//passing value of product
//                product_details_name: prod_name,
//              product_details_new_price: prod_price,
//                product_details_old_price: prod_old_price,
//             product_details_picture: prod_pricture,
//            ))),
//   child: GridTile(
//      footer: Container(
//         color: Colors.white,
//        child: Row(
//         children: <Widget>[
//          Expanded(
//            child: new Text(
//            prod_name,
//           style: TextStyle(
//                fontWeight: FontWeight.bold, fontSize: 16.0),
//         ),
//      ),
//    new Text(
//     "\Tk ${prod_price}",
//      style: TextStyle(
//          fontWeight: FontWeight.bold, color: Colors.red),
//    )
//  ],
//  )),
//  child: Image.asset(
//   prod_pricture,
//    fit: BoxFit.cover,
// )),
//  ),
//  )),
//   );
// }
//}
