class Favorite {
  String title;
  String postTime;
  String url;
  String authorName;

  Favorite({
    required this.title,
    required this.postTime,
    required this.url,
    required this.authorName
  });

  Map toJson() => {
      'title': title,
      'postTime': postTime,
      'url': url,
      'authorName': authorName
    };

  factory Favorite.fromJson(Map<String, dynamic> json){
    return Favorite(
      title: json['title'],
      postTime: json['postTime'],
      url: json['url'],
      authorName: json['authorName']
    );
  }
}
