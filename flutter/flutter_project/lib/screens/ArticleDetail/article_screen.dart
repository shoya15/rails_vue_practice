import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/article_detail.dart';

/// ブラウザの記事のページに遷移するための関数
class ArticleScreen extends StatelessWidget {
  const ArticleScreen({ 
    super.key,
    required this.currentArticle
  });

  final ArticleDetail currentArticle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Page')),
      body: WebView(initialUrl: currentArticle.url)
    );
  }
}
