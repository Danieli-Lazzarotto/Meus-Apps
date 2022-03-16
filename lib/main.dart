import 'package:conversormoedas/Apps/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json&key=6f301fec");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("mensagens").get();
  snapshot.docs.forEach((element) {
    print(element.data());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ));
  }
}

Future<Map> getData() async {
  var response = await http.get(request);
  return json.decode(response.body);
}
