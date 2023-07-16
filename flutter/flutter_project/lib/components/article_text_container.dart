import 'package:flutter/material.dart';
import 'package:flutter_project/models/article_text.dart';

class ArticleTextContainer extends StatelessWidget {
  const ArticleTextContainer({
    Key? key,
    required this.currentArticle,
  }) : super(key: key);

  final ArticleText currentArticle;

  @override
  Widget build(BuildContext context) {
    return Text(
        currentArticle.text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        )
    );
  }
}
