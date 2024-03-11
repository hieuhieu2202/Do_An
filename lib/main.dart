import 'package:delivery_food/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Dòng này đảm bảo rằng các liên kết của framework

  await Firebase.initializeApp();
  // Flutter được khởi tạo trước khi ứng dụng chạy
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller ',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

