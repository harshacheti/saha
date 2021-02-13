import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saha/pages/home_page.dart';
import 'package:saha/services/database.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:saha/pages/signup.dart';

import 'models/products_stream.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( StreamProvider<List<Product>>.value(value: Database().products, child:MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[50],
        accentColor: Colors.cyan[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //canvasColor: Colors.transparent,
      ),
      home: //CartLoading(),
          IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    //var net;
    //Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {result=net;});
    //print(net);
    return new SplashScreen(
        navigateAfterSeconds: result != null
            ? StreamProvider<Users>.value(
                value: Database().users, child: MyHomePage(uid: result.uid))
            : SignUp(),
        seconds: 5,
        image: Image.asset('assets/images/ENGLISH-TEL (TRANSPARENT).png',
            fit: BoxFit.scaleDown),
        photoSize: 200.0,
        onClick: () => print("flutter india"),
        loaderColor: Colors.blue);
  }
}
