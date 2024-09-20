import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googlemaps/components/glass_morphism.dart';
import 'package:googlemaps/helpers/helpers_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/button_custom.dart';
import '../components/textField_custom.dart';
import '../font_manager.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void register() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if (_passwordController.text != _confirmPasswordController.text) {
      Navigator.pop(context);
      displayErrorMessageToUser("Passwords do not match!", context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        createUserDocument(userCredential);
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayErrorMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({'email': userCredential.user!.email});
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
                  '    Create An Account',
                  style: FontManager().getTextStyle(context,
                      color: Colors.blueGrey,
                      lWeight: FontWeight.w600,
                      fontSize: 34),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Text(
                    //     'UserName',
                    //     style: FontManager().getTextStyle(context,
                    //         color: Colors.blueGrey,
                    //         lWeight: FontWeight.w600,
                    //         fontSize: 20),
                    //   ),
                    // ),
                    CustomTextField(
                      obscureText: false,
                      controller: _emailController,
                      hintText: "email",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Text(
                    //     'Password',
                    //     style: FontManager().getTextStyle(context,
                    //         color: Colors.blueGrey,
                    //         lWeight: FontWeight.w600,
                    //         fontSize: 20),
                    //   ),
                    // ),
                    CustomTextField(
                      obscureText: true,
                      controller: _passwordController,
                      hintText: "password",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Text(
                    //     'Confirm Password',
                    //     style: FontManager().getTextStyle(context,
                    //         color: Colors.blueGrey,
                    //         lWeight: FontWeight.w600,
                    //         fontSize: 20),
                    //   ),
                    // ),
                    CustomTextField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      hintText: "confirm password",
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      onTap: register,
                      text: 'Register',
                    ),
                    // SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 7,
                          bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'Already Have an Account',
                            style: FontManager().getTextStyle(context,
                                color: Colors.blueGrey,
                                lWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              ' Login ',
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
