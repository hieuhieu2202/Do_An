import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/global/global.dart';
import 'package:delivery_food/mainScreen/home_screen.dart';
import 'package:delivery_food/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/error_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({super.key});

  @override
  State<MenusUploadScreen> createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleInfoController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
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
        title: const Text(
          "Thêm đồ mới",
          style:
              TextStyle(color: Colors.red, fontFamily: "Lobster", fontSize: 30),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          },
        ),
      ),
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shop_two,
                color: Colors.white,
                size: 200,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                onPressed: () {
                  takeImage(context);
                },
                child: const Text(
                  "Thêm đồ mới",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mcontext) {
    return showDialog(
        context: mcontext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Ảnh Menu",
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                onPressed: captureImageWithCamera,
                child: const Text(
                  "Chụp ảnh",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                onPressed: captureImageFromGalley,
                child: const Text(
                  "Chọn ảnh từ thư viện",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SimpleDialogOption(
                child: const Text(
                  "Bỏ qua",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    imageFile = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);

    setState(() {
      imageFile;
    });
  }

  captureImageFromGalley() async {
    Navigator.pop(context);
    imageFile = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);

    setState(() {
      imageFile;
    });
  }

  menuUploadFromScreen() {
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
        title: const Text(
          "Thực đơn mới",
          style:
              TextStyle(color: Colors.red, fontFamily: "Lobster", fontSize: 30),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context);
            clearMenusUploadForm();
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          },
        ),
        actions: [
          TextButton(
              onPressed: uploading ? null : () => validateUploadForm(),
              child: const Text(
                "Thêm",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Lobster"),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageFile!.path)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.perm_device_information, color: Colors.cyan),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Chi tiết thực đơn",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.title, color: Colors.cyan),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleInfoController,
                decoration: const InputDecoration(
                  hintText: "Tựa đề cho Menu",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  clearMenusUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleInfoController.clear();
      imageFile = null;
    });
  }

  saveInfo(String downloadURL, String shortInfo, String titleInfo) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharePreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharePreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleInfoController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailURL": downloadURL,
    });

    clearMenusUploadForm();
    setState(() {
      uniqueIdName = "";
      uploading = false;
    });
  }

  void validateUploadForm() async {
    if (imageFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleInfoController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        String downloadURL = await uploadImage(File((imageFile!.path)));

        saveInfo(
            downloadURL, shortInfoController.text, titleInfoController.text);
      } else {
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Vui lòng nhập đủ thông tin cho menu",
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: "Chọn ảnh menu của cửa hàng",
          );
        },
      );
    }
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");
    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageFile == null ? defaultScreen() : menuUploadFromScreen();
  }
}
