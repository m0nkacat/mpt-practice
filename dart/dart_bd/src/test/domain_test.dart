import 'package:test/test.dart';
import 'package:dart_bd/dart_bd.dart';

void main() {
  group('User', () {
    test('toMap and fromMap', () {
      final user = User(
        id: 'u1',
        name: 'Иван',
        email: 'ivan@mail.ru',
        registeredAt: DateTime(2024, 1, 1, 12, 0),
      );
      final map = user.toMap();
      expect(map['id'], 'u1');
      expect(map['name'], 'Иван');
      expect(map['email'], 'ivan@mail.ru');
      expect(map['registeredAt'], '2024-01-01T12:00:00.000');

      final restored = User.fromMap(map);
      expect(restored.id, user.id);
      expect(restored.name, user.name);
      expect(restored.email, user.email);
      expect(restored.registeredAt, user.registeredAt);
    });
  });

  group('Question', () {
    test('toMap and fromMap', () {
      final q = Question(
        id: 'q1',
        userId: 'u1',
        title: 'Title',
        content: 'Content',
        createdAt: DateTime(2024, 5, 1, 8, 0),
        views: 10,
      );
      final map = q.toMap();
      expect(map['title'], 'Title');
      expect(map['views'], 10);
      final restored = Question.fromMap(map);
      expect(restored.title, q.title);
    });
  });

  group('Answer', () {
    test('toMap and fromMap', () {
      final a = Answer(
        id: 'a1',
        userId: 'u2',
        questionId: 'q1',
        content: 'Answer text',
        createdAt: DateTime.now(),
        isAccepted: true,
      );
      final map = a.toMap();
      expect(map['isAccepted'], 1);
      final restored = Answer.fromMap(map);
      expect(restored.isAccepted, true);
    });
  });

  group('Comment', () {
    test('toMap and fromMap', () {
      final c = Comment(
        id: 'c1',
        userId: 'u3',
        questionId: 'q1',
        answerId: null,
        content: 'Nice!',
        createdAt: DateTime.now(),
      );
      final map = c.toMap();
      expect(map['questionId'], 'q1');
      final restored = Comment.fromMap(map);
      expect(restored.questionId, 'q1');
      expect(restored.answerId, null);
    });
  });

  group('Tag', () {
    test('toMap and fromMap', () {
      final t = Tag(id: 't1', name: 'dart');
      final map = t.toMap();
      expect(map['name'], 'dart');
      final restored = Tag.fromMap(map);
      expect(restored.name, 'dart');
    });
  });
}