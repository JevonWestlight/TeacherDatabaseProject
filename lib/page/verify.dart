import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern2/page/home.dart';

class verify extends StatefulWidget {
  @override
  _verifyState createState() => _verifyState();
}

class _verifyState extends State<verify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      checkEmail();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text('An email has been sent to ${user.email} please verify'),
      )
    );
  }

  Future<void> checkEmail() async {
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
