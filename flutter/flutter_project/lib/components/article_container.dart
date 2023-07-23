import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/article.dart';
import '../models/favorite.dart';
import '../screens/ArticleDetail/article_detail_screen.dart';

class ArticleContainer extends StatefulWidget {
  const ArticleContainer({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  State<ArticleContainer> createState() => _ArticleContainer();
}

class _ArticleContainer extends State<ArticleContainer> {
  List<Favorite> favorite = [];

  /// お気に入り登録されているかどうかを示す変数
  bool isFavorite = false;

  /// お気に入り登録されているかどうかを返す関数
  judgeFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getKeys()
                        .contains('${widget.article.authorName}/${widget.article.title}');
    });
  }

  @override
  void initState() {
    super.initState();
    judgeFavorite();
  }

  Future addFavorite() async {
    favorite = [
      Favorite(
        title: widget.article.title,
        postTime: DateFormat('yyyy/MM/dd').format(DateTime.now()),
        url: widget.article.url,
        authorName: widget.article.authorName
      )
    ];

    List<String> favoriteArticle = favorite.map((f) => jsonEncode(f.toJson())).toList(); 

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('${widget.article.authorName}/${widget.article.title}', favoriteArticle);
  }

  removeFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('${widget.article.authorName}/${widget.article.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),

      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => ArticleDetailScreen(article: widget.article))
            ),
          );
        },

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 投稿日
                Text(
                  DateFormat('yyyy/MM/dd').format(widget.article.publishedAt),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),

                // タイトル
                Text(
                  widget.article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // タグ
                Text(
                  '#${widget.article.tags.join(' #')}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                // 作成者
                Text(
                  widget.article.authorName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  )
                ),

                // お気に入り
                OutlinedButton(
                  onPressed: () {
                    isFavorite ? removeFavorite() : addFavorite();
                  },
                  child: Text(
                    isFavorite ? 'お気に入りを外す' : 'お気に入り'
                  ),
                ),
              ]
            )
          )
        ),
      ),
    );
  }
}
