import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/article_container.dart';
import '../../components/article_detail_container.dart';
import '../../models/article_detail.dart';
import '../../models/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article
  });

  final Article article;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  ArticleDetail currentArticle = ArticleDetail(text: "", url: "");

  Future getArticle() async {
    final res = await getArticleDetail(widget.article.id);
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
        future: getArticleDetail(widget.article.id),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("LOADING..."));
          }else {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ArticleContainer(article: widget.article),
                      ArticleDetailContainer(currentArticle: currentArticle)
                    ],
                  )
                )
              ],
            );
          }
        },
      ),
      // リロードボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await getArticleDetail(widget.article.id);
          setState(() {
            currentArticle = res;
          });
        },
        child: const Icon(Icons.autorenew)
       ),
    );
  }
}

/// 記事の本文を取得するための関数
Future<ArticleDetail> getArticleDetail(articleId) async {
  final uri = Uri.parse('https://qiita.com/api/v2/items/$articleId');

  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  if(res.statusCode == 200) {
    final dynamic body = jsonDecode(res.body);
    return ArticleDetail.fromJson(body);
  }else {
    return ArticleDetail(text: "", url: "");
  }
}
