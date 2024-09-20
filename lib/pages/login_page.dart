import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googlemaps/components/button_custom.dart';
import 'package:googlemaps/components/textField_custom.dart';
import 'dart:io';
// import 'package:glassmorphism/glassmorphism.dart';
import 'package:googlemaps/font_manager.dart';
import 'package:googlemaps/helpers/helpers_function.dart';

import '../components/glass_morphism.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayErrorMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   foregroundColor: Theme.of(context).colorScheme.primary,
        // ),
        body: SingleChildScrollView(
          child: GlassmorphicContainer(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            borderRadius: 0,
            blur: 10,
            border: 0,
            linearGradient: LinearGradient(colors: [
              Color.fromARGB(255, 140, 169, 198),
              Colors.pink.shade200
            ]),
            borderGradient: const LinearGradient(colors: [
              Colors.white38,
              Colors.white54,
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    'assets/images/GroupOne.svg',
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '     Welcome To App..!!',
                  style: FontManager().getTextStyle(context,
                      color: Colors.blueGrey,
                      lWeight: FontWeight.w600,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'UserName',
                    //   style: FontManager().getTextStyle(context,
                    //       color: Colors.blueGrey,
                    //       lWeight: FontWeight.w600,
                    //       fontSize: 20),
                    // ),
                    CustomTextField(
                      obscureText: false,
                      controller: _emailController,
                      hintText: "email",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   'Password',
                    //   style: FontManager().getTextStyle(context,
                    //       color: Colors.blueGrey,
                    //       lWeight: FontWeight.w600,
                    //       fontSize: 20),
                    // ),
                    CustomTextField(
                      obscureText: true,
                      controller: _passwordController,
                      hintText: "password",
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      onTap: login,
                      text: 'Login',
                    ),
                    // const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 7,
                          bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Not a Member?',
                            style: FontManager().getTextStyle(context,
                                color: Colors.blueGrey,
                                lWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              ' Register Now',
                              style: FontManager().getTextStyle(context,
                                  color: Colors.blueGrey,
                                  lWeight: FontWeight.w800,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
