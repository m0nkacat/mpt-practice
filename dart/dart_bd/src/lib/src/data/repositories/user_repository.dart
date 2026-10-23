import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/user.dart';

class UserRepository {
  final Database db;
  UserRepository(this.db);

  void insert(User user) {
    db.execute(
      'INSERT OR REPLACE INTO users(id, name, email, registeredAt) VALUES(?, ?, ?, ?)',
      [user.id, user.name, user.email, user.registeredAt.toIso8601String()],
    );
  }

  List<User> getAll() {
    final result = db.select('SELECT * FROM users');
    return result.map((row) => User.fromMap(row)).toList();
  }

  User? getById(String id) {
    final result = db.select('SELECT * FROM users WHERE id = ?', [id]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  void update(User user) {
    db.execute(
      'UPDATE users SET name = ?, email = ?, registeredAt = ? WHERE id = ?',
      [user.name, user.email, user.registeredAt.toIso8601String(), user.id],
    );
  }

  void delete(String id) {
    db.execute('DELETE FROM users WHERE id = ?', [id]);
  }
}