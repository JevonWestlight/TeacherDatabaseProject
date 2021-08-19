import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intern2/page/add.dart';
import 'package:intern2/page/home.dart';
import 'package:intern2/page/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login Page')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            RaisedButton(
                color: Colors.lightGreen,
                child: Text('SignIn',
                style: TextStyle(
                  fontSize: 16,
                ),),
                onPressed: () => _signin(_email, _password)
            ),
            RaisedButton(
              color: Colors.amberAccent,
              child: Text('SignUp',
              style: TextStyle(
                fontSize: 16,
              ),),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => register()));
              },
            )
          ])
        ],
      ),
    );
  }

  _signin(String _email, String _password) async {
    try {
      //Create Get Firebase Auth User
      await auth.signInWithEmailAndPassword(email: _email, password : _password);

      //Success
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));

    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message,gravity: ToastGravity.TOP);
    }

  }
}