import 'package:flutter/material.dart';
import 'package:recipesapp/Register.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(
  ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    builder: (BuildContext context) {
      return AuthService();
    },
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodApp',
      theme: ThemeData(primarySwatch: Colors.red),
      home: FutureBuilder<FirebaseUser>(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) { //          ⇐ NEW
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console                                            ⇐ NEW
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            // redirect to the proper page, pass the user into the
            // `HomePage` so we can display the user email in welcome msg     ⇐ NEW
            return snapshot.hasData ? HomePage(snapshot.data) : LoginPage();
          } else {
            // show loading indicator                                         ⇐ NEW
            return LoadingCircle();
          }
        },
      ),
    );
  }
}
class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

