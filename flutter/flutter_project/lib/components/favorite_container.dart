import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/favorite.dart';
import '../screens/FavoriteArticle/favorite_screen.dart';

class FavoriteContainer extends StatefulWidget {
  const FavoriteContainer({
    Key? key,
    required this.favorite,
  }) : super(key: key);

  final Favorite favorite;

  @override
  State<FavoriteContainer> createState() => _FavoriteContainer();
}

class _FavoriteContainer extends State<FavoriteContainer> {
  removeArticle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('${widget.favorite.authorName}/${widget.favorite.title}');
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),

      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // お気に入りした日
              Text(
                widget.favorite.postTime,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),

              // タイトル
              Text(
                widget.favorite.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              // お気に入り解除ボタン
              OutlinedButton(
                onPressed: () {
                  removeArticle();
                },
                child: const Text('お気に入りを外す'),
                ),

              // ブラウザ遷移ボタン
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => FavoriteScreen(favorite: widget.favorite))
                    ),
                  );
                },
                child: const Text('ブラウザで見る'),
              ),
            ],
          )
        ),
      ),
    );
  }
}
