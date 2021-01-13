import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saha/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:saha/pages/home.dart';
import 'package:saha/pages/signup.dart';



void main() async {
  //print(0);
  //var l=[adfasdf32132,sdfasdf123123,asdfasdfsa132123];
  //var k=[{'id':'shyam','quaity':'lol'},{'id':'shyamk','quaity':'lolk'}];
  //print(k[0]['id']);
 // print(k[0]);
 // var idx = k.indexOf((e)=>e['id']=='shyam');
 // var shyam="shyam";
  //print(k.forEach((e)=>e.id==shyam));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash',
      theme: ThemeData(

        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[50],
        accentColor: Colors.cyan[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        navigateAfterSeconds: result != null ? MyHomePage(uid: result.uid) : SignUp(),
        seconds: 5,
        image: Image.asset('assets/images/ENGLISH-TEL (TRANSPARENT).png', fit: BoxFit.scaleDown),
        photoSize: 200.0,
        onClick: () => print("flutter india"),
        loaderColor: Colors.blue);
  }
}
