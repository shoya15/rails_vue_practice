import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_project/models/favorite.dart';

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
