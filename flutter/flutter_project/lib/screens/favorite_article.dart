import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter_project/models/favorite.dart';
import 'package:flutter_project/components/favorite_container.dart';

class FavoriteArticleScreen extends StatefulWidget {
  const FavoriteArticleScreen({super.key});

  @override
  State<FavoriteArticleScreen> createState() => _FavoriteArticleScreenState();
}

class _FavoriteArticleScreenState extends State<FavoriteArticleScreen> {
  List keys = [];
  List<Favorite> favorites = [];
  
  Future getFavoriteArticles() async {
    if(favorites != []) {
      favorites = [];
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getKeys().forEach((key) {
        List<String>? result = prefs.getStringList(key);
        Favorite favorite = result!.map((e) => Favorite.fromJson(jsonDecode(e))).single;
        favorites.add(favorite);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFavoriteArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Articles')),
        body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: favorites
                                .map((favorite) => FavoriteContainer(favorite: favorite))
                                .toList()
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final res = await getFavoriteArticles();
                  if(res != null) {
                    setState(() {
                      favorites = res;
                    });
                  }
                },
                child: const Icon(Icons.autorenew)
              ),
      );
  }
}
