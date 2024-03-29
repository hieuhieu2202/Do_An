import 'dart:async';

import 'package:delivery_food/authentication/auth_screen.dart';
import 'package:delivery_food/global/global.dart';
import 'package:delivery_food/mainScreen/home_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(
      const Duration(seconds: 8),
      () async {
        // Nếu đã đăng nhập
        if (firebaseAuth.currentUser != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        }
        else {
          //Nếu chưa đăng nhập
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const AuthScreen()));
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
              const SizedBox(
                height: 8,
              ),
              const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Sell Food Online",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 40,
                      fontFamily: "Signatra",
                      letterSpacing: 3,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
