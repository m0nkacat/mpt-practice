import 'package:dart_bd/dart_bd.dart';

void main() {
  final db = MailruDatabase.open();
  db.createTables();
  final menu = Menu(db);
  menu.run();
  db.dispose();
}

