  import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/question.dart';

class QuestionRepository {
  final Database db;
  QuestionRepository(this.db);

  void insert(Question q) {
    db.execute(
      'INSERT OR REPLACE INTO questions(id, userId, title, content, createdAt, views) VALUES(?, ?, ?, ?, ?, ?)',
      [q.id, q.userId, q.title, q.content, q.createdAt.toIso8601String(), q.views],
    );
  }

  List<Question> getAll() {
    final rows = db.select('SELECT * FROM questions');
    return rows.map((r) => Question.fromMap(r)).toList();
  }

  Question? getById(String id) {
    final rows = db.select('SELECT * FROM questions WHERE id = ?', [id]);
    return rows.isNotEmpty ? Question.fromMap(rows.first) : null;
  }

  void update(Question q) {
    db.execute(
      'UPDATE questions SET userId = ?, title = ?, content = ?, createdAt = ?, views = ? WHERE id = ?',
      [q.userId, q.title, q.content, q.createdAt.toIso8601String(), q.views, q.id],
    );
  }

  void delete(String id) {
    db.execute('DELETE FROM questions WHERE id = ?', [id]);
  }

 
  void addTag(String questionId, String tagId) {
    db.execute('INSERT OR IGNORE INTO question_tags(questionId, tagId) VALUES(?, ?)', [questionId, tagId]);
  }

  List<String> getTagIds(String questionId) {
    final rows = db.select('SELECT tagId FROM question_tags WHERE questionId = ?', [questionId]);
    return rows.map((r) => r['tagId'] as String).toList();
  }
}