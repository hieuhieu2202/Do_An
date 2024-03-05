import 'package:delivery_food/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController anyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: anyController,
          data: Icons.phone,
          hintText: "Số điện thoại",
          isObsecre: false,
        ),
        CustomTextField(
          controller: anyController,
          data: Icons.lock,
          hintText: "Số điện thoại",
          isObsecre: false,
        ),
      ],
    );
  }
}
