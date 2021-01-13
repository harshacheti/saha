import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

var state;

first() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((d) {
    var com = d.data()["cart"];
    print(com);
    if (com == "") {
      state = [];
    } else {
      state = deSerializeItems(com);
    }
  });
}

main() {
  const twentyMillis = const Duration(milliseconds: 1);
  new Timer(twentyMillis, () => first());
}


serializeItems(items) {
  var cart = [];
  //print(items);
  items.forEach((item) =>
  {
    cart.add(item['id'] + ";" + item['quantity'].toString())
  });

  return cart.join(",");
}

deSerializeItems(cart) {
  var items = [];
  print(cart);
  if (cart == '') {
    return items;
  }
  else {
    var citems = cart.split(",");
    //print(citems);
    citems.forEach((c) {
      var sc = c.split(";");
      //print(sc);
      if (sc.length == 2) items.add(
          {'id': sc[0], 'quantity': int.parse(sc[1])});
    });
    return items;
  }
}


removeaItem(items, id){
var idx = items.indexWhere((item) => item['id'] == id);
if (idx != -1) {
return [...items.sublist(0, idx), ...items.sublist(idx + 1)];
} else return [];
}

incrementItem(items, count, id, doc) {
  // print(items);
  //var idx = items.findIndex(items['id'],'$id') ;
  var idx = items.indexWhere((item) => item['id'] == id);
  print('$idx');

  if (idx != -1) {
    var count = items[idx]['quantity'];
    count++;
    return [
      ...items.sublist(0, idx),
      {
        'id': id,
        'quantity': count,
      },
      ...items.sublist(idx + 1),
    ];
  } else
    return [];
}


decrementItem(items, id) {
  var idx = items.indexWhere((item) => item['id'] == id);
  if (idx != -1) {
    var count = items[idx]['quantity'];
    count--;
    return [
      ...items.sublist(0, idx),
      {
        'id': id,
        'quantity': count,
      },
      ...items.sublist(idx + 1),
    ];
  } else
    return [];
}


addItem(var item, a) async {
  print(state);
  var idx = state.indexWhere((a) => a['id'] == item);
  print(idx);
  if (idx == -1) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((d) {
      var doc = d.data()["cart"];
      if (doc == "") {
        return item + ";1";
      } else {
        return doc + "," + item + ";1";
      }
    }).then((l) {
      print(l);
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({
        'cart': l,
      });
      first();
    });

  }
  else {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    //print(item);
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get()
        .then((d) {
      var doc = d.data()["cart"];
      var items = deSerializeItems(doc);
      var newItems = incrementItem(items, a, item, doc);
      print(newItems);
      return serializeItems(newItems);
    }).then((cart) {
      //print(cart);
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({
        'cart': '$cart',
      });
      first();
    });
  }
}

split() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var cart;
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((d) {
    cart = d.data()["cart"];
    //print(cart);
    var split = cart.split(",");
    //print(split);
    return split;
  });
}

remove(var a,) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var rat;
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((d) {
    rat = d.data()["cart"];
    // print(cart.length);
    var lit = rat;
    var upCart = lit.replaceFirst('$a,', '');
    //var cry=upCart.join(', ');
    print(lit);
    print(upCart);
    //  print(cry);
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "cart": "$upCart",
    }).then((_) {
      AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
      );
    });
  });
}


removeItem(item, val) {
//return (dispatch, getState, { getFirebase, getFirestore }) => {
//var state = getState();
//const firestore = getFirestore();
  var elPos = state.indexWhere((el) => el['id'] == item);
  if (elPos != -1) {
    var count = state[elPos]['quantity'];
    count--;
// add new count to quantity to existing object
   // var payload = { 'id': item.id, count: count, 'pos': elPos};
    if (count > 0) {
      //if (state.firebase.auth.uid) {
        FirebaseFirestore.instance
            .collection("users")
            .doc( FirebaseAuth.instance.currentUser.uid)
            .get()
            .then((d) {
          var doc = d.data();
          var items = deSerializeItems(doc['cart']);
          var newItems = decrementItem(items, item);
          return serializeItems(newItems);
        })
            .then((cart) {
           FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({ 'cart': '$cart'}); first();
        });
  //.catch((e) => dispatch({ type: "ADD_NEW_ITEM_FIRESTORE_ERR", e }));
  }
 // dispatch({ type: "DECREMENT_COUNT", payload });
 // }
  else {
 // if (state.firebase.auth.uid) {
    FirebaseFirestore.instance
      .collection("users")
      .doc( FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((d) {
  var doc = d.data();
  var items = deSerializeItems(doc['cart']);
  var newItems = removeaItem(items, item);
  return serializeItems(newItems);
  })
      .then((cart) {
   FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .update({ cart: cart }); first();
  });
     // .catch((e) => dispatch({ type: "ADD_NEW_ITEM_FIRESTORE_ERR", e }));
  }
 // dispatch({ type: "REMOVE_ITEM", payload });
 // }
}
//};
}