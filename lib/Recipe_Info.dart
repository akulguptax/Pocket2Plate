//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Home.dart';

//https://api.spoonacular.com/recipes/complexSearch?apiKey=97058fb1917646efaee70ec6af0765ba
//https://api.spoonacular.com/recipes/716426/information?apiKey=97058fb1917646efaee70ec6af0765ba


class Recipe_Info extends StatefulWidget {
  @override
  String id;
  String url;
  Recipe_Info(String setId, String setUrl) {
    id = setId;
    url = setUrl;
  }
  _Recipe_Info createState() => _Recipe_Info(id, url);
}

class _Recipe_Info extends State<Recipe_Info> {
  Map data;
  List recipeData;
  String id;
  String url;

  _Recipe_Info(String setId, String setUrl) {
    id = setId;
    url = setUrl;
  }

  Future getData(String setId, String setUrl) async {
    http.Response response = await http.get(
        "https://api.spoonacular.com/recipes/"+ setId +"/information?apiKey=a30b7731b96f4d1da8b7d868cee7c97f");
    data = json.decode(response.body);
    setState(() {
      print(data);
      recipeData = data["extendedIngredients"];
    });
  }



  @override
  void initState() {
    super.initState();
    getData(id, url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Information"),
        backgroundColor: Color.fromRGBO(255, 0, 0, 100),
      ),
      body: ListView.builder(
        itemCount: recipeData == null ? 0 : recipeData.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0) {
            return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                
                children: <Widget>[
                  Text("${data["title"]} \n"),
                  Image.network(url),
                  Text("\n"),
                  new Html(data: "\n ${data["summary"]}".replaceAll("<b>", "").replaceAll("</b>", "").replaceAll("${data["summary"]}".substring("${data["summary"]}".indexOf("Try")), "")),
                  Text("\nList of Ingredients:\n"),
                  GestureDetector(
                    child: Text(
                      "Ingredient: ${recipeData[index]["name"]}\nAmount: ${recipeData[index]["original"]}\nConsistency: ${recipeData[index]["consistency"]}",
                      textAlign: TextAlign.left,
                      maxLines: 100,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          }
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print("Clicked on card");
                      //navigateToSubPage(context);
                    },
                    child: Text(
                      "${recipeData[index]["name"]}\nAmount: ${recipeData[index]["original"]}\nConsistency: ${recipeData[index]["consistency"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}