import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/cart.dart';
import 'package:saha/actions/payment_actions.dart';
import 'package:saha/components/badge.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/searchpage.dart';
import 'package:saha/pages/signup.dart';
import 'package:saha/payment/checkout_screen.dart';
import 'package:saha/services/database.dart';
import 'bottom_nav_categorie_page.dart';
import 'bottom_nav_help_page.dart';
import 'bottom_nav_offers_page.dart';
import 'bottom_nav_profile_page.dart';
import 'home_page.dart';
import 'orders_page.dart';

class AppbarBottomNav extends StatefulWidget {

  AppbarBottomNav({this.uid});
  final String uid;

  @override
  _AppbarBottomNavState createState() => _AppbarBottomNavState();


}

class _AppbarBottomNavState extends State<AppbarBottomNav> {
  int _pageIndex = 0;


  PageController _pageController;
  List<Widget> tabPages = [
  StreamProvider<Users>.value(
  value: Database().users, child: MyHomePage()),
    BottomNavCategoriePage(),
    BottomNavProfilePage(),
    BottomNavOfferPage(),
    BottomNavHelpPage(),
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new SearchBar()));
              }),

          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch,),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StreamProvider<Users>.value(
                              value: Database().users, child: CheckoutScreen())));
                }),
          ),
         /* IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StreamProvider<Users>.value(
                          value: Database().users, child: CheckoutScreen())));
            },
            icon: new Stack(children: <Widget>[
              new Icon(
                Icons.shopping_cart,
                color: Colors.blueGrey,
              ),


              //new Positioned(
                // draw a red marble
              //  top: 0.0,
              //  right: 0.0,
              //  child: new Icon(Icons.brightness_1,
              //      size: 10.0, color: Colors.redAccent),
              //)
            ]),
            // Icon(Icons.shopping_cart),
            //color: Colors.blueGrey,
            // tooltip: "My Cart",
          )*/
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName:
              //Text(FirebaseAuth.instance.currentUser.uid),

              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .get(),
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
              onTap: () {
                Navigator.of(context).pop();
              },
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new OrdersPage()));
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider<Users>.value(
                            value: Database().users,
                            child: CheckoutScreen())));
              },
              child: ListTile(
                title: Text('Shoping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            InkWell(
              onTap: () {
               // makeCodRequest();
              },
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new SignUp()));
              },
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 25,
        backgroundColor: Colors.white70,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        onTap:onTabTapped,
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
        //onTap: (index) {
        //  setState(() {
        //   _currentIndex = index;
        //}
        // );
        //},
      ),
      body:PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ) ,


    );

  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }
}
