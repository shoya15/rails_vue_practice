class ArticleDetail {
  final String text;
  final String url;

  ArticleDetail({
    required this.text,
    required this.url
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
      text: json['body'],
      url:  json['url']
    );
  }
}
