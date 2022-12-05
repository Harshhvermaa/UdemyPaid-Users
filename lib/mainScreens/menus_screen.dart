import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:udemy_paid_users/assisstentMethods/assisstant_methods.dart';
import 'package:udemy_paid_users/widgets/menus_design.dart';
import 'package:udemy_paid_users/widgets/my_drawer.dart';

import '../Models/menus.dart';
import '../Models/models.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        leading: IconButton(
            onPressed: () {
              clearCartNow(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
              // Get.snackbar("Cart Removed", "Cart Removed Successfuly");
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            widget.model!.sellerName! + "Menus",
            style: TextStyle(fontSize: 20),
          )),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return !snapshot.hasData
                    ? circularProgress()
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Menus sModel = Menus.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return Column(
                            children: [
                              MenusDesignWidget(
                                context: context,
                                model: sModel,
                              ),
                            ],
                          );
                        });
              },
            ),
          ),
        ],
      ),
      // CustomScrollView(
      //   slivers: [
      //     SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + " Menus")),
      //     StreamBuilder<QuerySnapshot>(
      // stream: FirebaseFirestore.instance
      //     .collection("sellers")
      //     .doc(widget.model!.sellerUID)
      //     .collection("menus")
      //     .orderBy("publishedDate", descending: true)
      //     .snapshots(),
      //       builder: (context, snapshot)
      //       {
      //         return !snapshot.hasData
      //             ? SliverToBoxAdapter(
      //           child: Center(child: circularProgress(),),
      //         )
      //             : SliverStaggeredGrid.countBuilder(
      //           crossAxisCount: 1,
      //           staggeredTileBuilder: (c) => StaggeredTile.fit(1),
      //           itemBuilder: (context, index)
      //           {
      //             Menus model = Menus.fromJson(
      //               snapshot.data!.docs[index].data()! as Map<String, dynamic>,
      //             );
      //             return MenusDesignWidget(
      //               model: model,
      //               context: context,
      //             );
      //           },
      //           itemCount: snapshot.data!.docs.length,
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
