class Task {
  final String content;
  final int userId;
  final bool status;

  Task({
    required this.content,
    required this.userId,
    required this.status
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      content: json['content'],
      userId : json['user_id'],
      status : json['status']
    );
  }
}
