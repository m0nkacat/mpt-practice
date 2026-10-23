import 'identity.dart';

class Answer implements Identity {
  @override
  final String id;
  final String userId;
  final String questionId;
  final String content;
  final DateTime createdAt;
  final bool isAccepted;

  Answer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.content,
    required this.createdAt,
    required this.isAccepted,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'questionId': questionId,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'isAccepted': isAccepted ? 1 : 0,
  };

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] as String,
      userId: map['userId'] as String,
      questionId: map['questionId'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      isAccepted: (map['isAccepted'] as int) == 1,
    );
  }

  @override
  String toString() => 'Ответ на вопрос $questionId: ${content.substring(0, content.length > 30 ? 30 : content.length)}...';
}