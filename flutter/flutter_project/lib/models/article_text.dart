class ArticleText {
  final String text;
  final String url;

  ArticleText({
    required this.text,
    required this.url
  });

  factory ArticleText.fromJson(Map<String, dynamic> json) {
    return ArticleText(
      text: json['body'],
      url:  json['url']
    );
  }
}
