class Favorite {
  String title;
  String postTime;
  String url;

  Favorite({
    required this.title,
    required this.postTime,
    required this.url
  });

  Map toJson() => {
    'title': title,
    'postTime': postTime,
    'url': url
  };

  factory Favorite.fromJson(Map json){
    return Favorite(
      title: json['title'],
      postTime: json['postTime'],
      url: json['url']
    );
  }
}
