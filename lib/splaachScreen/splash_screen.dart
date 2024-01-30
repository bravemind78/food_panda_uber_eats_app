// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_panda_uber_eats_app/authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(Duration(seconds: 5), () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AuthenticationScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash.jpg'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sell Food Online',
              style: TextStyle(
                  fontFamily: 'Signatra',
                  fontSize: 48,
                  letterSpacing: 5,
                  color: Colors.grey[600]),
            )
          ],
        ),
      ),
    ));
  }
}
