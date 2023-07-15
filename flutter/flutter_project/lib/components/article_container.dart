import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/article.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),

      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 投稿日
            Text(
              DateFormat('yyyy/MM/dd').format(article.publishedAt),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),

            // タイトル
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            // タグ
            Text(
              '#${article.tags.join(' #')}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),

            // 作成者
            Text(
              article.authorName,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              )
            ),
          ]
        )
      ),
    );
  }
}
