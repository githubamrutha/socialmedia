import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googlemaps/components/glass_morphism.dart';
import 'package:googlemaps/font_manager.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: GlassmorphicContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        borderRadius: 0,
        blur: 10,
        border: 0,
        linearGradient: LinearGradient(colors: [
          Color.fromARGB(255, 140, 169, 198),
          const Color.fromARGB(255, 248, 211, 223)
        ]),
        borderGradient: const LinearGradient(colors: [
          Colors.white38,
          Colors.white54,
        ]),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/GroupTwo.svg',
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("error ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    Map<String, dynamic>? user = snapshot.data!.data();
                    return Text(
                      user!["email"],
                      style: FontManager().getTextStyle(context,
                          color: Colors.blueGrey,
                          lWeight: FontWeight.w600,
                          fontSize: 20),
                    );
                  } else {
                    return Text("No Data");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
