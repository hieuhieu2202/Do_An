import 'package:delivery_food/uploadScreens/item_upload_screen.dart';
import 'package:delivery_food/widgets/my_drawer.dart';
import 'package:delivery_food/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../model/menus.dart';

class ItemScreen extends StatefulWidget {
  final Menus? model;

  ItemScreen({this.model});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Icons.library_add,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ItemUploadScreen(model: widget.model)));
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
                title: "My" + widget.model!.menuTitle.toString() + " Item"),
          ),
        ],
      ),
    );
  }
}
