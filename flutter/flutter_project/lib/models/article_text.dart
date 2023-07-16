class ArticleText {
  final String text;

  ArticleText({required this.text});

  factory ArticleText.fromJson(Map<String, dynamic> json) {
    return ArticleText(text: json['body']);
  }
}
