import 'package:flutter/material.dart';
import 'package:flutter_project/models/article_text.dart';
import 'package:flutter_project/screens/article_screen.dart';

class ArticleTextContainer extends StatelessWidget {
  const ArticleTextContainer({
    Key? key,
    required this.currentArticle,
  }) : super(key: key);

  final ArticleText currentArticle;

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
