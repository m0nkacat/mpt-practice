import 'identity.dart';

class Comment implements Identity {
  @override
  final String id;
  final String userId;
  final String? questionId;
  final String? answerId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    this.questionId,
    this.answerId,
    required this.content,
    required this.createdAt,
  }) : assert(questionId != null || answerId != null);

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'questionId': questionId,
    'answerId': answerId,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      userId: map['userId'] as String,
      questionId: map['questionId'] as String?,
      answerId: map['answerId'] as String?,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  @override
  String toString() => 'Коммент от $userId: ${content.substring(0, content.length > 20 ? 20 : content.length)}...';
}