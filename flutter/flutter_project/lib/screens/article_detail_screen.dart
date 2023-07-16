import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_project/models/article_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_project/components/article_container.dart';
import 'package:flutter_project/components/article_text_container.dart';
import 'package:flutter_project/models/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    required this.article,
    super.key
  });

  final Article article;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  ArticleText currentArticle = ArticleText(text: "");

  Future getArticle() async {
    final res = await getArticleText(widget.article.id);
    setState(() {
      currentArticle = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Detail')),
      body: FutureBuilder(
        future: getArticleText(widget.article.id),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("LOADING..."));
          }else {
            if(currentArticle.text == "") {
              return const Center(child: Text("NO Article"));
            }else {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ArticleContainer(article: widget.article),
                        ArticleTextContainer(currentArticle: currentArticle)
                      ],
                    )
                  )
                ],
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await getArticleText(widget.article.id);
          setState(() {
            currentArticle = res;
          });
        },
        child: const Icon(Icons.autorenew)
       ),
    );
  }
}

Future<ArticleText> getArticleText(articleId) async {
  final uri = Uri.parse('https://qiita.com/api/v2/items/$articleId');

  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  if(res.statusCode == 200) {
    final dynamic body = jsonDecode(res.body);
    return ArticleText.fromJson(body);
  }else {
    return ArticleText(text: "");
  }
}
