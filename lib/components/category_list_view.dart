import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saha/components/design_course_app_theme.dart';
//import 'package:saha/components/category.dart';
import 'package:flutter/material.dart';
import 'package:saha/pages/category_listview_page.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 100,
        width: double.infinity,
        child: StreamBuilder(
          //future: getData(),
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                //itemCount: Category.categoryList.length,
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = snapshot.data.documents.length > 10
                      ? 10
                      : snapshot.data.documents.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  DocumentSnapshot category = snapshot.data.documents[index];

                  return CategoryView(
                    category_details_id: category.id,
                    category_details_name:
                    category.data()['title'],
                    category_details_img:
                    category.data()['imageURL'],
                    //category: category,
                    animation: animation,
                    animationController: animationController,
                    callback: () {
                      widget.callBack();
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
        this.category_details_id,
        this.category_details_name,
        this.category_details_img,
      this.category,
      this.animationController,
      this.animation,
      this.callback, })
      : super(key: key);
  final category_details_id;
  final category_details_name;
  final category_details_img;
  final VoidCallback callback;
  final CategoryListView category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () =>
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new CategoryDetails(
                        //passing value of product
                        category_details_id: category_details_id,
                        category_details_name:
                        category_details_name,
                        // product_details_new_price: products.data()['totalPrice'],
                        // product_details_old_price: products.data()['Price'],
                        // product_details_picture: products.data()['imageURL'],
                      ))),
              child: SizedBox(
                width: 280,
                height: 100,
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                            height: 100,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 18.0,
                                    height: 100,
                                  ),
                                  Expanded(
                                    child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              category_details_name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ),
                                      ),
                                ],
                              ),
                           ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 275,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 7, bottom: 7, left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(

                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.network(category_details_img,)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
