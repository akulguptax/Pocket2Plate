import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//search
class SearchTab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Search(),
    );
  }
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Search extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Search> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;
  Map data;
  List recipeData;

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    List<Post> posts = [];

    for (int i = 0; i < recipeData.length; i++) {
      String title = recipeData.asMap()[i]["title"];

      if (title.contains(text)) {
        posts.add(Post(title, title));
      }
    }

    return posts;
  }

  //get results from api
  Future getData() async {
    http.Response response = await http.get(
        //8b67b4abf7654aef837608b0a7ff06c3
        //a30b7731b96f4d1da8b7d868cee7c97f
        "https://api.spoonacular.com/recipes/complexSearch?apiKey=8b67b4abf7654aef837608b0a7ff06c3");
    data = json.decode(response.body);
    setState(() {
      recipeData = data["results"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      body: SafeArea(
        child: SearchBar<Post>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) =>
              ScaledTile.count(1, index.isEven ? 2 : 1),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            //container
            return Container(
              child: ListTile(
                title: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(recipeData[index]["image"]),
                ),
                isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
              //stylize the box
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
