import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saha/services/database.dart';


class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference dbRef = FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up"),backgroundColor: Colors.white70,),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom:10.0),
                  child: Image.asset("assets/images/ENGLISH-TEL (TRANSPARENT).png"),),
              Padding(
                padding: EdgeInsets.only(top:10.0,bottom: 10,left: 20,right: 20),
                child: TextFormField(

                  cursorColor: Theme.of(context).primaryColor,
                  controller: nameController,
                  decoration: InputDecoration(

                    fillColor: Theme.of(context).primaryColor,
                    hoverColor: Theme.of(context).primaryColor,
                    labelText: "Enter User Name",
                    enabledBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter User Name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter an Email Address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Enter Phone Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Phone Number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                child: TextFormField(

                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(

                    labelText: "Enter Password",
                    enabledBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    } else if (value.length < 6) {
                      return 'Password must be atleast 6 characters!';
                    }
                    return null;
                  },
                ),
              ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                    child: DropdownButtonFormField(
                      value: pincodeController,
                      items:<DropdownMenuItem> [
                        //DropdownMenuItem<String>(key:Key("lol") ,onTap:(){},value:"1",child:Text("testx")),
                       // DropdownMenuItem(value: 1,child:new Text('lol'),onTap:(){})
                      ],
                      decoration: InputDecoration(

                        labelText: "Select Pin code",
                        enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.

                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                child: isLoading ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            registerToFb();
                          }
                        },
                        child: Text('Submit'),
                      ),
              )
            ]))));
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.doc(result.user.uid).set({
        "name": nameController.text,
        "email": emailController.text,
        "pNum": phoneController.text,
        "pincode":"",
        "cart":"",
        "isAdmin":false,
        "isGuest":false,
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StreamProvider<Users>.value(
          value: Database().users, child:MyHomePage(
          title: 'home',
        )),
        ));
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }
}
