import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'home_page.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  final FirebaseUser currentUser;
  Profile(this.currentUser);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            Image.asset("assets/images/logo.png", height: 100, width: 100),
            Text(
              '\n User Email:  ${widget.currentUser.email}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("LOGOUT"),
                onPressed: () async {
                  await Provider.of<AuthService>(context).logout();

                  //Navigator.pushReplacementNamed(context, "/");
                })
          ],
        ),
      ),
    );
  }
}