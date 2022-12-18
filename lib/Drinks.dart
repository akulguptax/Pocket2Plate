import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:recipesapp/Recipe_Info.dart';

String id;

class Drinks extends StatefulWidget {
  @override
  _Drinks createState() => _Drinks();
}

class _Drinks extends State<Drinks> {
  Map data;
  List recipeData;

  Future getData() async {
    http.Response response = await http.get(
        "https://api.spoonacular.com/recipes/complexSearch?apiKey=a30b7731b96f4d1da8b7d868cee7c97f&query=drink");
    data = json.decode(response.body);
    setState(() {
      recipeData = data["results"];
    });
  }



  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(

        itemCount: recipeData == null ? 0 : recipeData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      String id = recipeData[index]["id"].toString();
                      String url = recipeData[index]["image"];
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => Recipe_Info(id, url)));
                    },
                    child: CircleAvatar(
                    backgroundImage: NetworkImage(recipeData[index]["image"]),
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String id = recipeData[index]["id"].toString();
                      String url = recipeData[index]["image"];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Recipe_Info(id, url)));
                    },
                    child: Flexible ( 
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                      child: Text(
                      "${recipeData[index]["title"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                      )
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}