import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saha/pages/category_listview_page.dart';

class Horizontallist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 120.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot category = snapshot.data.documents[index];

                  return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => new CategoryDetails(
                                      //passing value of product
                                      category_details_id: category.id,
                                      category_details_name:
                                          category.data()['title'],
                                      // product_details_new_price: products.data()['totalPrice'],
                                      // product_details_old_price: products.data()['Price'],
                                      // product_details_picture: products.data()['imageURL'],
                                    ))),
                        child: //ClipRRect(
                          //width: 100.0,
                          //elevation: 2,

                          //borderRadius: BorderRadius.circular(5.0),
                          //child:
                          Container(

                            width: MediaQuery.of(context).size.width * 0.4,
                            //height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            //height: 2,
                            child: ListTile(

                                leading:Image.network(category['imageURL'] ,fit: BoxFit.fill,
                                 alignment: Alignment.center,
                                ),
                              title: Container(alignment: Alignment.center,
                              //height: 20,
                              child: new Text(
                                category['title'],
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: true),
                              ),),
                            ),
                          ),
                        ),
                     // )
                  );
                }),
          );
        });
  }
}

/*class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 100.0,
                height: 80.0,
              ),
              subtitle: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                            image_caption,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: true),
                          ))
                    ],
                  ))),
        ),
      ),
    );
  }
}*/
