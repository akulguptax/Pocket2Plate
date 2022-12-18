import 'package:flutter/material.dart';
import 'Home.dart';
import 'Drinks.dart';
import 'Recipe_Info.dart';
import 'Photo.dart';
import 'Starred.dart';
import 'Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser currentUser;
  HomePage(this.currentUser);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final tabController = new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Pocket2Plate"),
            ),
            backgroundColor: Colors.red,
          ),
          bottomNavigationBar: new BottomAppBar(
              child: new TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 2.0,
                tabs: [
                  new Tab(icon: new Icon(Icons.home), text: "Home"),
                  new Tab(icon: new Icon(Icons.local_drink), text: "Drinks"),
                  new Tab(icon: new Icon(Icons.search), text: "Search"),
                  new Tab(icon: new Icon(Icons.person_outline), text: "Profile")
                ],
              ),
              color: Colors.red),
          body: new TabBarView(children: [
            new Home(),
            new Drinks(),
            new SearchTab(),
            new Profile(widget.currentUser),
          ]),
        ));
    return new MaterialApp(title: "Tabs example", home: tabController);
  }
}
