import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saha/actions/cart_functions.dart';
import 'package:saha/components/category_list_view.dart';
import 'package:saha/components/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saha/pages/searchpage.dart';
import 'package:saha/pages/signup.dart';
import 'package:saha/payment/checkout_screen.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({this.uid, this.title});
  final String uid;
  final String title;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final User user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser.displayName;
  @override
  Widget build(BuildContext context) {
    first();
    //gives the current user doc id
    print(widget.uid);
    Widget imageCarousel = new Container(
      height: 200.0,

      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/c1.jpg'),
          AssetImage('assets/images/c2.jpg'),
          AssetImage('assets/images/c2.jpg'),
          AssetImage('assets/images/c1.jpg'),
          AssetImage('assets/images/c1.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/updlogo.png',
              height: 62,
              width: 186,
            ),
          ],
        ),
        titleSpacing: -10.0,

        //leading: Builder(
        // builder: (BuildContext context) {
        //   return IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //     tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //    );
        //  },
        // ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search),
              color: Colors.blueGrey,
              onPressed: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new SearchBar()));}),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new CheckoutScreen()));
            },
            icon:  new Stack(
                children: <Widget>[
                  new Icon(Icons.shopping_cart,color: Colors.blueGrey,),

                  new Positioned(  // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: new Icon(Icons.brightness_1, size: 10.0,
                        color: Colors.redAccent),
                  )
                ]
            ),
            // Icon(Icons.shopping_cart),
           //color: Colors.blueGrey,
           // tooltip: "My Cart",
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName:
              //Text(FirebaseAuth.instance.currentUser.uid),


        FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              return Text(snapshot.data['name']);
            } else {
              return CircularProgressIndicator();
            }
          }),
              //accountEmail: //Text(FirebaseAuth.instance.currentUser.email),
              /*FutureBuilder(
                 future: FirebaseFirestore.instance.collection('users').doc(widget.uid).get(),
                  builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      return Text(snapshot.data['email']);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),*/
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.lightBlue[50]),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account '),
                leading: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Shoping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favorites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.live_help,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new SignUp()));},
              child: ListTile(
                subtitle: Text('Sign out'),
                //leading: Icon(
               //   Icons.live_help,
                //  color: Colors.blue,
              //  ),
              ),
            ),
          ],
        ),
      ),
      /*appBar: AppBar(
        title: Text(widget.title),

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),*/
      /*body: FutureBuilder(
        future: getimgfromFirebase(),
        builder: (_, snapshot) {
          return CarouselSlider.builder(
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot sliderimage = snapshot.data[index];
              return Container(
                child: Image.network(sliderimage["img"]),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
            ),
            itemCount: snapshot.data.length,
          );
        },
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 25,
        backgroundColor: Colors.white70,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.deepPurple),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.deepPurple),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            title: Text(
              'Offer',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              // ignore: deprecated_member_use
              title: Text(
                'Help',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.deepPurple),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: new ListView(
        children: <Widget>[
          imageCarousel,
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Categories',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          //horizontal list view
          CategoryListView(),
         // Divider(),
          //recent product
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Recent Post',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),

          //grid view
          //SizedBox(child: Products(),height: MediaQuery.of(context).size.height*0.5,),
          Products(),

          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'New Products',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          Products(),
          //Divider(),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Trending',
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfffc5185)),
              ),
            ),
          ),
          Products(),
          //Divider(),
        ],
      ),
    );
  }
}