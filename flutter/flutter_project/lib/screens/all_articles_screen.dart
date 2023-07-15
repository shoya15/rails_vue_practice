import 'package:flutter_project/components/article_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/article.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key});

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  List<Article> articles = [];
  
  Future getArticles() async {
    final res = await getQiitaTrend();
    setState(() {
      articles = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qiita Trend Search')),
      body: FutureBuilder(
        future: getQiitaTrend(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("LOADING..."));
          }else {
            if(articles.isEmpty) {
              return const Center(child: Text("NO Articles"));
            }else {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: articles
                        .map((article) => ArticleContainer(article: article))
                        .toList()
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await getQiitaTrend();
          setState(() {
            articles = res;
          });
        },
        child: const Icon(Icons.autorenew)
       ),
    );
  }
}

Future<List<Article>> getQiitaTrend() async {
  final uri = Uri.parse('https://qiita-api.vercel.app/api/trend');

  final http.Response res = await http.get(uri);

  if(res.statusCode == 200) {
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  }else {
    return [];
  }
}
