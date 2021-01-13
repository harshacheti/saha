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