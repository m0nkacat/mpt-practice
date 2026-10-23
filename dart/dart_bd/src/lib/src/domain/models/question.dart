import 'identity.dart';

class Question implements Identity {
  @override
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;
  final int views;

  Question({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.views,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'views': views,
  };

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      views: map['views'] as int,
    );
  }

  @override
  String toString() => title;
}