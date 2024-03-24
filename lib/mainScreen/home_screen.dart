import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/authentication/auth_screen.dart';
import 'package:delivery_food/global/global.dart';
import 'package:delivery_food/uploadScreens/menus_upload_screen.dart';
import 'package:delivery_food/widgets/my_drawer.dart';
import 'package:delivery_food/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/menus.dart';
import '../widgets/info_design.dart';
import '../widgets/progress_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Màu sắc bóng đổ
                  offset: const Offset(0, 10), // Vị trí bóng đổ
                  blurRadius: 5.0, // Độ lan tỏa của bóng đổ
                )
              ],
              gradient: const LinearGradient(
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
        title: Text(
          sharePreferences!.getString("name")!,
          style: const TextStyle(
              color: Colors.red, fontFamily: "Lobster", fontSize: 30),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.post_add,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MenusUploadScreen()));
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true, delegate: TextWidgetHeader("Menu của tôi")),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharePreferences!.getString("uid"))
                  .collection("menus")
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverGrid.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: snapshot.data!.docs.map((index) {
                          Menus sMenu = Menus.fromJson(
                              index.data() as Map<String, dynamic>);
                          return InfoDesignWidget(sMenu, context);
                        }).toList(),
                      );
              })
        ],
      ),
    );
  }
}
