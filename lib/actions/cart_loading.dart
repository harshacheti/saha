import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/payment_actions.dart';
import 'package:saha/models/user.dart';
import 'button_color.dart';
import 'cart_functions.dart';

 //var list = [];

class CartLoading extends StatefulWidget {
  @override
  _CartLoadingState createState() => _CartLoadingState();
}

class _CartLoadingState extends State<CartLoading> {
  var list=[];
  var items;
  var lolPrice;
  var res = 0;

 _listenToData(){
    FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid).snapshots().listen((snap){
      items = deSerializeItems(snap.data()['cart']);
      //list.clear();
      //var chai=[];
      items.forEach((d) {
        FirebaseFirestore.instance
            .collection("products")
            .doc(d['id'])
            .get()
            .then((value) {
          list.add(value);
          //return chai;
          // print(value.data()['price']);
          //  sam(value.data());

          //list.add(value.data());
          // print(list);
        });
      });
    });
  }

  calcTPrice(){
    //if (list.length == 0) return 0;

    list.forEach((i){
      print('hello');
      var idx = items.indexWhere((item) => item['id'] == i.id);
      print(i.id);
      res = res + (i['totalPrice']*items[idx]['quantity']);
    });
    return res;
  }

  @override
  initState(){
    _listenToData();
    lolPrice = calcTPrice();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        calcTPrice();
        // Here you can write your code for open new view
      });
    });


    //_CartLoadingState();
    _buildAllAds();
    super.initState();
  }


   _buildAllAds() {


    //FutureBuilder(future:list ,
     // builder:(context, AsyncSnapshot<List> snapshot){
     // if(snapshot.hasData){
    //    print(snapshot.data);
    //    return Text('hello');
     // }
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                      onTap: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            // ignore: missing_return
                              builder: (context) {})),
                      child: Container(
                        height: 110,
                        //child: Card(
                        //width: 100,
                        // height:100 ,
                        // semanticContainer : true,
                        // elevation: 2,
                        // shape: RoundedRectangleBorder(
                        //    borderRadius: BorderRadius.circular(10.0),
                        //  ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          trailing:

                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("\₹ ${list[index]['totalPrice']}",
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                            //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                            //textHeightBehavior:
                            // TextHeightBehavior(
                            //     applyHeightToFirstAscent: true),
                          ),

                          //tileColor: Colors.white,
                          //leading: Container(
                          // height: 150,
                          //  width: 100,
                          //  child: Image.network(
                          //   products['imageURL'],
                          //    alignment: Alignment.center,
                          //  )),
                          title: Row(children: <Widget>[
                            Image.network(
                              list[index]['imageURL'],
                              alignment: Alignment.centerLeft,
                            ),
                            Flexible(
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      list[index]['title'],
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: true),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:60.0),
                                  child: ButtonColor(
                                    product_details_id: list[index].id,),
                                  )
                                ]
                                )),
                          ]),
                          //Text(products['title']),
                          //),
                        ),
                        //    )
                      ))

                // ignore: missing_return
              );
            }
      //  );*/
    //  },
      );



   }


  @override
  Widget build(BuildContext context) {
   //calcTPrice();


    return Scaffold(

      body: _buildAllAds(),

      bottomNavigationBar: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total amount:'+ '$res',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                //_openRazorpay();
                 
                //  setState(() {
                //future() ;
                //  print(list.length);
                //   });
              },
              //_openRazorpay(),
              child: Text(
                'CHECKOUT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );

      _buildAllAds();

     // var userList = Provider.of<Users>(context);
      // print(userList.cart);
    //  var items = deSerializeItems(userList.cart);
    //  items.forEach((masa) {
    //    FirebaseFirestore.instance
     //       .collection("products")
     //       .doc(masa['id'])
     //       .get()
      //      .then((value) {
      //    list.add(value);
          //  print(value.id);
          // print(value.data()['price']);
          //  sam(value.data());
          //list.add(value.data());
          // print(list);
     //   });
     // });


   //   return

     //FutureBuilder(
     //    future:  items.forEach((masa) {
     //      FirebaseFirestore.instance
     //          .collection("products")
      //         .doc(masa['id'])
       //        .get()
       //        .then((value) {
        //     list.add(value);
             //print(value.id);
             // print(value.data()['price']);
             //  sam(value.data());
             //list.add(value.data());
             // print(list);
        //   }) ;
       //  }),
       //   builder: (context, snapshot) {
       //    print(snapshot);
           /* return ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  print(list[index]['title']);
                  print(list.length);
                  return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                          onTap: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                                  // ignore: missing_return
                                  builder: (context) {})),
                          child: Container(
                            height: 110,
                            //child: Card(
                            //width: 100,
                            // height:100 ,
                            // semanticContainer : true,
                            // elevation: 2,
                            // shape: RoundedRectangleBorder(
                            //    borderRadius: BorderRadius.circular(10.0),
                            //  ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text("\₹ ${list[index]['price']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                                //textHeightBehavior:
                                // TextHeightBehavior(
                                //     applyHeightToFirstAscent: true),
                              ),

                              //tileColor: Colors.white,
                              //leading: Container(
                              // height: 150,
                              //  width: 100,
                              //  child: Image.network(
                              //   products['imageURL'],
                              //    alignment: Alignment.center,
                              //  )),
                              title: Row(children: <Widget>[
                                Image.network(
                                  list[index]['imageURL'],
                                  alignment: Alignment.centerLeft,
                                ),
                                Flexible(
                                    child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      list[index]['title'],
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: true),
                                    ),
                                  ),
                                ])),
                              ]),
                              //Text(products['title']),
                              //subtitle: Divider(thickness: 1,),

                              //),
                            ),
                            //    )
                          ))

                      // ignore: missing_return
                      );
                });
            //list=[];
       //   },*/
     //  );


  }
}
