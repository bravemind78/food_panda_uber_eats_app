// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_panda_uber_eats_app/widgets/customized_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /* -------------------------------------------------------------------------- */
  /*                            variables Definitions                           */
  /* -------------------------------------------------------------------------- */
  /* ---------------------------- Global Variables ---------------------------- */
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  /* -------------------- Text Editing Controller Variables ------------------- */
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset('images/seller.png'),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    customizedFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      prefix: Icons.email,
                      label: 'Enter Your Email',
                      hintText: 'Email',
                    ),
                    customizedFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock,
                        label: 'Enter password',
                        hintText: 'Password',
                        isPassword: true),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
