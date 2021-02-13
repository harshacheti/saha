import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:provider/provider.dart';
import 'package:saha/actions/AlgoliaApplication.dart';
import 'package:flutter/material.dart';
import 'package:saha/models/user.dart';
import 'package:saha/pages/product_details.dart';
import 'package:saha/services/database.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("products").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(children: <Widget>[
            TextField(
                onChanged: (val) {
                  setState(() {
                    _searchTerm = val;
                  });
                },
                style: new TextStyle(color: Colors.black, fontSize: 20),
                decoration: new InputDecoration(
                    //border: ,
                  fillColor: Colors.pinkAccent,
                    hintText: 'Search ...',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.search, color: Colors.black))),
            StreamBuilder<List<AlgoliaObjectSnapshot>>(
              stream: Stream.fromFuture(_operation(_searchTerm)),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Padding(padding: EdgeInsets.all(9), child:Text(
                    'Enter Text',
                    style: TextStyle(color: Colors.black),
                  ));
                else {
                  List<AlgoliaObjectSnapshot> currSearchStuff = snapshot.data;
                  //print(currSearchStuff);

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return CustomScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          //const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return _searchTerm.length > 0
                                      ? DisplaySearchResult(
                                          count: _searchTerm.length,
                                          artDes: currSearchStuff[index]
                                              .data["title"],
                                          artistName: currSearchStuff[index]
                                              .data["description"],
                                          genre: currSearchStuff[index]
                                              .data["imageURL"],
                                          proTolprice: currSearchStuff[index]
                                              .data["totalPrice"],
                                          price: currSearchStuff[index]
                                              .data["Price"],
                                        )
                                      : Container();
                                },
                                childCount: currSearchStuff.length ?? 0,
                              ),
                            ),
                          ],
                        );
                  }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class DisplaySearchResult extends StatelessWidget {
  final String artDes;
  final String artistName;
  final String genre;
  final int proTolprice;
  final int price;
  final int count;

  DisplaySearchResult(
      {Key key,
      this.artistName,
      this.artDes,
      this.genre,
      this.count,
      this.proTolprice,
      this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        /*ListView.builder(itemCount: count,
        itemBuilder: (context, index)
    {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
            onTap: () => Navigator.of(context)
                .push(new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                  //passing value of product
                  product_details_name:
                  artDes,
                  product_details_new_price:
                  proTolprice,
                  product_details_old_price:
                  price,
                  product_details_picture:
                  genre,
                  product_details_description:
                  artistName,
                ))),
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
                      genre ?? "",
                      alignment: Alignment.centerLeft,
                    ),
                    Flexible(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              artDes ?? "",
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textHeightBehavior:
                              TextHeightBehavior(
                                  applyHeightToFirstAscent:
                                  true),
                            ),
                          )
                        ]))
                  ]),
                  //Text(products['title']),
                  //subtitle: Divider(thickness: 1,),
                 // trailing: Padding(
                   // padding: const EdgeInsets.all(6.0),
                   // child: Text("\₹ ${products['price']}",
                   //     style: TextStyle(
                        //    fontWeight: FontWeight.bold)),
                    //subtitle: Text(products['description'],overflow: TextOverflow.visible,softWrap: true,
                    //textHeightBehavior:
                    // TextHeightBehavior(
                    //     applyHeightToFirstAscent: true),
               //   ) //),
              ),
              //    )
            )));
    }
    );*/
      InkWell(
    onTap: () => Navigator.of(context)
        .push(new MaterialPageRoute(
    builder: (context) => StreamProvider<Users>.value(
        value: Database().users, child:new ProductDetails(
    //passing value of product
    product_details_name:
    artDes,
    product_details_new_price:
    proTolprice,
    product_details_old_price:
    price,
    product_details_picture:
    genre,
    product_details_description:
    artistName,
    )))),
       child: Column(children: <Widget>[

      Row(children: <Widget>[
        Container(
          height: 70,
          width: 70,
          child: Image.network(genre ?? ""),
        ),
        Expanded(
            child: Container(
          //alignment: Alignment.center,
          child: Text(
            artDes ?? "",
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.visible,
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: true),
            style: TextStyle(color: Colors.black),
          ),
        ))
      ]),

      //Text(
      // artistName ?? "",
      // style: TextStyle(color: Colors.black),
      //),
      // Text(
      //  genre ?? "",
      //  style: TextStyle(color: Colors.black),
      // ),
      Divider(
        color: Colors.black,
      ),
      SizedBox(height: 20)
    ]));
  }
}
