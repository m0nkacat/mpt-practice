import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/comment.dart';

class CommentRepository {
  final Database db;
  CommentRepository(this.db);

  void insert(Comment c) {
    db.execute(
      'INSERT OR REPLACE INTO comments(id, userId, questionId, answerId, content, createdAt) VALUES(?, ?, ?, ?, ?, ?)',
      [c.id, c.userId, c.questionId, c.answerId, c.content, c.createdAt.toIso8601String()],
    );
  }

  List<Comment> getAll() {
    final rows = db.select('SELECT * FROM comments');
    return rows.map((r) => Comment.fromMap(r)).toList();
  }

  Comment? getById(String id) {
    final rows = db.select('SELECT * FROM comments WHERE id = ?', [id]);
    return rows.isNotEmpty ? Comment.fromMap(rows.first) : null;
  }

  void update(Comment c) {
    db.execute(
      'UPDATE comments SET userId = ?, questionId = ?, answerId = ?, content = ?, createdAt = ? WHERE id = ?',
      [c.userId, c.questionId, c.answerId, c.content, c.createdAt.toIso8601String(), c.id],
    );
  }

  void delete(String id) {
    db.execute('DELETE FROM comments WHERE id = ?', [id]);
  }
}