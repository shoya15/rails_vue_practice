class Article {
  final String title;
  final DateTime publishedAt;
  final String authorName;
  final String linkUrl;
  final String id;
  final List<String> tags;

  Article({
    required this.title,
    required this.publishedAt,
    required this.authorName,
    required this.linkUrl,
    required this.id,
    this.tags = const []
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['node']['title'],
      publishedAt: DateTime.parse(json['node']['publishedAt'].toString()),
      authorName: json['node']['author']['urlName'],
      linkUrl: json['node']['linkUrl'],
      id: json['node']['uuid'],
      tags: List<String>.from(json['node']['tags'].map((tag) => tag['name']))
    );
  }
}
