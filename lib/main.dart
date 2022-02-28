import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_farm/core/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDCevz7D4YZ9ganUGjplhZI1ZboaLtlDmQ",
          authDomain: "local-farm-ff7b7.firebaseapp.com",
          databaseURL:
              "https://local-farm-ff7b7-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "local-farm-ff7b7",
          storageBucket: "local-farm-ff7b7.appspot.com",
          messagingSenderId: "591234143954",
          appId: "1:591234143954:web:e1d54540bbc587bc1fbf0b"),
    );
  } catch (ex) {
    print(ex.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "NotoSansTC",
      ),
      home: const AppView(),
    );
  }
}
