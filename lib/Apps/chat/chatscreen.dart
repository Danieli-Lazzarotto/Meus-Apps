import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conversormoedas/Apps/chat/chatmessage.dart';
import 'package:conversormoedas/Apps/chat/text_composer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser != null
            ? 'ola, ${currentUser!.displayName}'
            : 'chat app'),
        elevation: 0,
        actions: [
          currentUser != null
              ? IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    googleSignIn.signOut();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("voce saiu")));
                  },
                  icon: Icon(Icons.exit_to_app),
                )
              : Container()
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot?>(
              stream: FirebaseFirestore.instance
                  .collection("Messages")
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ChatMessage(
                            documents[index].data() as Map<String, dynamic>,
                            true);
                      },
                    );
                }
              },
            ),
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMessages),
        ],
      ),
    );
  }

  void _sendMessages({String? text, File? imgFile}) async {
    final User? user = await _getUser();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error"),
        backgroundColor: Colors.red,
      ));
    }

    Map<String, dynamic> data = {
      'uid': user?.uid,
      'senderName': user?.displayName,
      'senderPhotoUrl': user?.photoURL,
      'userEmail': user?.email,
      'time': Timestamp.now(),
    };

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(user!.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      setState(() {
        _isLoading = true;
      });

      String urlImg = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = urlImg;

      setState(() {
        _isLoading = false;
      });
    }
    if (text != null) data['text'] = text;
    FirebaseFirestore.instance.collection('Messages').add(data);
  }

  _getUser() async {
    if (currentUser != null) return currentUser;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      return user;
    } catch (error) {
      return null;
    }
  }
}
