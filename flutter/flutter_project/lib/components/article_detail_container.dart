import 'package:flutter/material.dart';

import '../models/article_detail.dart';
import '../screens/ArticleDetail/article_screen.dart';

class ArticleDetailContainer extends StatelessWidget {
  const ArticleDetailContainer({
    Key? key,
    required this.currentArticle,
  }) : super(key: key);

  final ArticleDetail currentArticle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ArticleScreen(currentArticle: currentArticle))
                ),
              );
            },
            child: const Text('ブラウザで見る'),
          ),
          Text(
            currentArticle.text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            )
          ),
        ])
    );
  }
}
