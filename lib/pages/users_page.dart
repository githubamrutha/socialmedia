import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/user-tile.dart';
import 'chat_page.dart';
// import 'package:googlemaps/components/user-tile.dart';

class UsersPage extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users Page"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("error ${snapshot.error}");
              }
              if (snapshot.data == null) {
                return Text("no data");
              }

              final users = snapshot.data!.docs;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (user["email"] != currentUser!.email) {
                    return UserTile(
                      text: user["email"],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      recieverEmail: user["email"],
                                      recieverID: user["email"],
                                    )));
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            }));
  }
}
