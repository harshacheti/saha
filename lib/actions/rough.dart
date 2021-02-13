import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

addIt(){
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((d) {
    var doc = d.data()["cart"];
   // print(doc);
    var gam= doc.indexOf('Ht8lb0snTLYI44k6J1au');
    //print(gam);
  });
}







// var d = FirebaseFirestore.instance
//    .collection("users")
//    .doc(firebaseUser.uid)
//    .get().then((d) {
// doc = d.data()["cart"];
// print(cart.length);
//  tata = deSerializeItems(doc);
//});
//final items;
//print(tata);
// var idx = tata.indexOf((q) => q['id'] == 'item');
// print(tata[0]['id']);
//  print(idx);
// if (idx == -1) {
//  FirebaseFirestore.instance
//      .collection("users")
//      .doc(firebaseUser.uid)
//      .update({
//    'cart': doc + '$item' + ';' + '1,'});
//  }
// else {


//List uniqueList = Set.from(items).toList();


//var idx= doc.indexOf('$id');
// print(items[0]);
// uniqueList.map((id) {
//  String idx = uniqueList.indexOf(id);
//print(idx);
//return something;
// });

// items.forEach((a){
//  if(a['id']=='$id'){
//print(id);
//a['quatity']
// a['quatity']='$count';
//   }
// print(items);
//   return items;
// });


// print(reya);
// print(items.forEach());
// print(id);
// print(count);
// if (idx != -1) {
//var count = id;
//  return [
//    ...items.replace(0, idx),
//    {
//      'id': id,
//      'quantity': count,
//    },
//    ...items.replace(idx + 1),
//   ];
// } else
//   return [
//     {
//      'id': '$id',
//      'quantity': '$count',
//    }
//   ];

//child: Card(
//width: 100,
// height:100 ,
// semanticContainer : true,
// elevation: 2,
// shape: RoundedRectangleBorder(
//    borderRadius: BorderRadius.circular(10.0),
//  ),


//tileColor: Colors.white,
//leading: Container(
// height: 150,
//  width: 100,
//  child: Image.network(
//   products['imageURL'],
//    alignment: Alignment.center,
//  )),

//Text(products['title']),
//subtitle: Divider(thickness: 1,),


//subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
//textHeightBehavior:
// TextHeightBehavior(
//     applyHeightToFirstAscent: true),

// ignore: missing_return
/*item(sam) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((d) {
    var doc = d.data();
    //print(doc['cart']);
    var items = deSerializeItems(doc['cart']);
    list=[];

    //print(lol);
    return items;
  }).then((lol) {
    lol.forEach((masa) {
      FirebaseFirestore.instance
          .collection("products")
          .doc(masa['id'])
          .get()
          .then((value) {
        list.add(value);

        // print(value.data()['price']);
        //  sam(value.data());

        //list.add(value.data());
        // print(list);
      });
    });
  });
}

main() {
  const twentyMillis = const Duration(milliseconds: 1);
  new Timer(twentyMillis, () => CheckoutScreen());
}*/

// Timer.periodic(Duration(seconds: 1), (t) {
//   list=[];
//  setState(() {
//item(sam);
// });
//  list=[];
// });

//future();

// var product_on_the_cart = [item()];