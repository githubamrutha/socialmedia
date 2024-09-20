import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/components/textField_custom.dart';
import 'package:googlemaps/services/chat/chat_service.dart';

// import '../font_manager.dart';
import 'package:googlemaps/font_manager.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;

  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  final TextEditingController _messageController = TextEditingController();
  final ChatService chatService = ChatService();
  // final AuthService authService = AuthServ

  // send messages
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(recieverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = FirebaseAuth.instance.currentUser!.email!;
    return StreamBuilder(
        stream: chatService.getMessages(recieverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc, context))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderID'] == FirebaseAuth.instance.currentUser!.email;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 4),
      child: Container(
          alignment: alignment,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 140, 169, 198),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 4,
              ),
              child: Text(
                data["message"],
                style: FontManager().getTextStyle(context,
                    color: const Color.fromARGB(255, 250, 252, 252),
                    lWeight: FontWeight.w500,
                    fontSize: 15),
              ))),
    );
  }

  Widget _buildUserInput() {
    return Column(
      children: [
        CustomTextField(
            obscureText: false,
            controller: _messageController,
            hintText: "Type something"),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
