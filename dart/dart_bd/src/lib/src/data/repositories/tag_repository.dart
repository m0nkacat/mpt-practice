import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/tag.dart';

class TagRepository {
  final Database db;
  TagRepository(this.db);

  void insert(Tag t) {
    db.execute('INSERT OR REPLACE INTO tags(id, name) VALUES(?, ?)', [t.id, t.name]);
  }

  List<Tag> getAll() {
    final rows = db.select('SELECT * FROM tags');
    return rows.map((r) => Tag.fromMap(r)).toList();
  }

  Tag? getById(String id) {
    final rows = db.select('SELECT * FROM tags WHERE id = ?', [id]);
    return rows.isNotEmpty ? Tag.fromMap(rows.first) : null;
  }

  Tag? getByName(String name) {
    final rows = db.select('SELECT * FROM tags WHERE name = ?', [name]);
    return rows.isNotEmpty ? Tag.fromMap(rows.first) : null;
  }

  void update(Tag t) {
    db.execute('UPDATE tags SET name = ? WHERE id = ?', [t.name, t.id]);
  }

  void delete(String id) {
    db.execute('DELETE FROM tags WHERE id = ?', [id]);
  }
}