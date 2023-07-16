import 'package:flutter/material.dart';
import 'package:flutter_project/models/article_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({ 
    super.key,
    required this.currentArticle
  });

  final ArticleText currentArticle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Page')),
      body: WebView(initialUrl: currentArticle.url)
    );
  }
}
