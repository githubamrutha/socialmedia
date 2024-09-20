import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/components/custom_drawer.dart';
import 'package:googlemaps/components/custom_post_button.dart';
import 'package:googlemaps/components/glass_morphism.dart';
import 'package:googlemaps/components/textField_custom.dart';
import 'package:googlemaps/database/firestore.dart';
import 'package:googlemaps/font_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController _saySomethingController = TextEditingController();

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (_saySomethingController.text.isNotEmpty) {
      String message = _saySomethingController.text;
      database.addPost(message);
    }

    _saySomethingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: 30,
          //   width: 30,
          //   color: Colors.blue,
          // ),
          CustomTextField(
            obscureText: false,
            controller: _saySomethingController,
            hintText: "Say Something..",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: CustomPostButton(onTap: postMessage),
          ),

          //posts displaying
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;

                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Text("No Posts"),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        String message = post["PostMessage"];
                        String userEmail = post["UserEmail"];
                        Timestamp timestamp = post["TimeStamp"];

                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GlassmorphicContainer(
                              // height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: 15,
                              blur: 10,
                              border: 0,
                              linearGradient: LinearGradient(colors: [
                                Color.fromARGB(255, 97, 148, 199),
                                const Color.fromARGB(255, 209, 222, 230)
                              ]),
                              borderGradient: const LinearGradient(colors: [
                                Colors.white38,
                                Colors.white54,
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  message,
                                  style: FontManager().getTextStyle(context,
                                      color: Colors.blueGrey,
                                      lWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                            child: Text(userEmail),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}
