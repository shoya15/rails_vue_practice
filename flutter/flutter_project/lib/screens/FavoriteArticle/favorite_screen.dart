import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/favorite.dart';

/// ブラウザの記事のページに遷移するための関数
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({ 
    super.key,
    required this.favorite,
  });

  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Page')),
      body: WebView(initialUrl: favorite.url)
    );
  }
}
