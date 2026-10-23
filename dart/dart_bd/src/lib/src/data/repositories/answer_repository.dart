import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/answer.dart';

class AnswerRepository {
  final Database db;
  AnswerRepository(this.db);

  void insert(Answer a) {
    db.execute(
      'INSERT OR REPLACE INTO answers(id, userId, questionId, content, createdAt, isAccepted) VALUES(?, ?, ?, ?, ?, ?)',
      [a.id, a.userId, a.questionId, a.content, a.createdAt.toIso8601String(), a.isAccepted ? 1 : 0],
    );
  }

  List<Answer> getAll() {
    final rows = db.select('SELECT * FROM answers');
    return rows.map((r) => Answer.fromMap(r)).toList();
  }

  Answer? getById(String id) {
    final rows = db.select('SELECT * FROM answers WHERE id = ?', [id]);
    return rows.isNotEmpty ? Answer.fromMap(rows.first) : null;
  }

  void update(Answer a) {
    db.execute(
      'UPDATE answers SET userId = ?, questionId = ?, content = ?, createdAt = ?, isAccepted = ? WHERE id = ?',
      [a.userId, a.questionId, a.content, a.createdAt.toIso8601String(), a.isAccepted ? 1 : 0, a.id],
    );
  }

  void delete(String id) {
    db.execute('DELETE FROM answers WHERE id = ?', [id]);
  }
}