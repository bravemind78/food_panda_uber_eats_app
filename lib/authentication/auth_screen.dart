// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_panda_uber_eats_app/authentication/login_screen.dart';
import 'package:food_panda_uber_eats_app/authentication/register_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.cyan, Colors.amber]))),
              title: Text(
                'iFood',
                style: TextStyle(fontSize: 60, fontFamily: 'Lobster'),
              ),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      text: 'Login'),
                  Tab(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      text: 'Register')
                ],
                indicatorColor: Colors.white38,
                indicatorWeight: 6,
              )),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.amber],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: TabBarView(children: [
              LoginScreen(),
              RegisterScreen(),
            ]),
          ),
        ));
  }
}
