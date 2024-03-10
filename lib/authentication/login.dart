import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "images/seller.png",
                height: 270,
              ),
            ),
          ),
          Form(key: _formKey,
          child: Column(
            children: [
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
            ],
          ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () => print("Clicked Đăng nhập"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10)
            ),
            child: const Text(
              "Đăng nhập",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
