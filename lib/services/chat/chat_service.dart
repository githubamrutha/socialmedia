import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; //get instance of firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> sendMessage(String recieverId, message) async {
    final String currentUserID = _auth.currentUser!.email!;
    final String currentUserEmail = currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

// creating a new message
    Message newMessage = Message(
        senderID: currentUserEmail,
        senderEmail: currentUserID,
        receiverID: recieverId,
        message: message,
        timestamp: timestamp);

    //create chat room id for two users
    List<String> ids = [currentUserID, recieverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages(retrieve)
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
