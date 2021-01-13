import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saha/actions/button_color.dart';
import 'package:saha/pages/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'design_course_app_theme.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Container(
          height: 210,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,

              // shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              //padding: const EdgeInsets.all(5.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                //print(snapshot.data.documents[index].data());
                DocumentSnapshot products = snapshot.data.documents[index];
                var productsId = products.id;

                return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) =>
                                new ProductDetails(
                                  //passing value of product
                                  product_details_name:
                                  products.data()['title'],
                                  product_details_new_price:
                                  products.data()['totalPrice'],
                                  product_details_old_price:
                                  products.data()['Price'],
                                  product_details_picture:
                                  products.data()['imageURL'],
                                  product_details_description:
                                  products.data()['description'],
                                  product_details_id: products.id,
                                ))),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.74,
                          child: ListTile(

                              contentPadding: EdgeInsets.all(5.0),
                              title: //Hero(
                              // tag: products['imageURL'].toString(),
                              //child:
                              Image.network(products['imageURL'])
                              //)
                              ,
                              subtitle: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(children: <Widget>[
                                    Text(
                                      products['title'],
                                      textAlign: TextAlign.left,
                                      style: DesignCourseAppTheme.subtitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: true),
                                    ),

                                    //CustomStepper(lowerLimit: 0,
                                    // upperLimit: 20,
                                    // stepValue: 1,
                                    // iconSize: 15.0,
                                    // value: 0,
                                    // product_details_id: products.id),
                                    ButtonColor(
                                      product_details_id: products.id,),
                                  ])
                                //),
                              )),
                        )));
              }
          )
      );
    }else{
      return CircularProgressIndicator(value: 5,);
    }
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


