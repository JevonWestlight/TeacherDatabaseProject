import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern2/page/add.dart';
import 'package:intern2/page/listStu.dart';
import 'package:intern2/page/login.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child:
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
              decoration: ShapeDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.lightGreen]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
              child: Row(
              children: [
                Icon(
                  Icons.school,
                  color: Colors.black,
                  size: 30,
                ),
                Text('   Students',
                  style: TextStyle(
                      color: Colors.black,
                    fontSize: 20.0,
                  ),),
              ],
            ),
          ),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => listStudent()));
            },
          ),
          SizedBox(height: 35,),
          RaisedButton(child:
          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
            decoration: ShapeDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.black26]),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text('   Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),),
              ],
            ),
          ),
            padding: EdgeInsets.zero,
            onPressed: (){
            auth.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          },),
        ],
      ),
    );
  }
}