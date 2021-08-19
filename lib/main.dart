import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intern2/page/add.dart';
import 'package:intern2/page/home.dart';
import 'package:intern2/page/listStu.dart';

import 'page/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
          accentColor: Colors.orange,
          primarySwatch: Colors.blue
      ),
      home: LoginScreen(),
    );
  }
}

