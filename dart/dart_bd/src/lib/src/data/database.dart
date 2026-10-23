import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'repositories/user_repository.dart';
import 'repositories/question_repository.dart';
import 'repositories/answer_repository.dart';
import 'repositories/comment_repository.dart';
import 'repositories/tag_repository.dart';

class MailruDatabase {
  final Database sqlite;
  late final UserRepository userRepo;
  late final QuestionRepository questionRepo;
  late final AnswerRepository answerRepo;
  late final CommentRepository commentRepo;
  late final TagRepository tagRepo;

  MailruDatabase._(this.sqlite) {
    userRepo = UserRepository(sqlite);
    questionRepo = QuestionRepository(sqlite);
    answerRepo = AnswerRepository(sqlite);
    commentRepo = CommentRepository(sqlite);
    tagRepo = TagRepository(sqlite);
  }

  static MailruDatabase open({String dataDir = 'data'}) {
    Directory(dataDir).createSync(recursive: true);
    final filePath = p.join(dataDir, 'mailru.db');
    return MailruDatabase._(sqlite3.open(filePath));
  }

  void createTables() {
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        registeredAt TEXT NOT NULL
      )
    ''');
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS questions (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        views INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS answers (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        questionId TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        isAccepted INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (questionId) REFERENCES questions(id) ON DELETE CASCADE
      )
    ''');
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS comments (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        questionId TEXT,
        answerId TEXT,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (questionId) REFERENCES questions(id) ON DELETE CASCADE,
        FOREIGN KEY (answerId) REFERENCES answers(id) ON DELETE CASCADE,
        CHECK (questionId IS NOT NULL OR answerId IS NOT NULL)
      )
    ''');
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS tags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE
      )
    ''');
    sqlite.execute('''
      CREATE TABLE IF NOT EXISTS question_tags (
        questionId TEXT NOT NULL,
        tagId TEXT NOT NULL,
        PRIMARY KEY (questionId, tagId),
        FOREIGN KEY (questionId) REFERENCES questions(id) ON DELETE CASCADE,
        FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
      )
    ''');
  }

  void dispose() {
    sqlite.dispose();
  }
}