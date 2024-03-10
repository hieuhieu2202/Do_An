import 'dart:io';

import 'package:delivery_food/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.2,
                  backgroundColor: Colors.white,
                  backgroundImage: imageXFile == null
                      ? null
                      : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          size: MediaQuery.of(context).size.width * 0.2,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        data: Icons.person,
                        controller: nameController,
                        hintText: "Họ và tên",
                        isObsecre: false,
                      ),
                      CustomTextField(
                        data: Icons.email,
                        controller: emailController,
                        hintText: "Email",
                        isObsecre: false,
                      ),
                      CustomTextField(
                        data: Icons.lock,
                        controller: passwordController,
                        hintText: "Mật khẩu",
                        isObsecre: true,
                      ),
                      CustomTextField(
                        data: Icons.lock,
                        controller: confirmPasswordController,
                        hintText: "Nhập lại mật khẩu",
                        isObsecre: true,
                      ),
                      CustomTextField(
                        data: Icons.phone,
                        controller: phoneController,
                        hintText: "Số điện thoại",
                        isObsecre: false,
                      ),
                      CustomTextField(
                        data: Icons.my_location,
                        controller: locationController,
                        hintText: "Địa chỉ",
                        isObsecre: false,
                        enabled: false,
                      ),
                      Container(
                        width: 400,
                        height: 40,
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          label: const Text(
                            "Địa chỉ hiện tại",
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          onPressed: () => print("Clicked"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => print("Clicked Đăng ký"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10)
                ),
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
