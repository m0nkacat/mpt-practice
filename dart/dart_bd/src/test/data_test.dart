import 'package:test/test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:dart_bd/dart_bd.dart';

void main() {
  late Database db;
  late UserRepository userRepo;
  late QuestionRepository questionRepo;
  late AnswerRepository answerRepo;
  late CommentRepository commentRepo;
  late TagRepository tagRepo;

  setUp(() {

    db = sqlite3.open(':memory:');

   
    db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        registeredAt TEXT NOT NULL
      )
    ''');
    db.execute('''
      CREATE TABLE questions (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        views INTEGER NOT NULL
      )
    ''');
    db.execute('''
      CREATE TABLE answers (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        questionId TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        isAccepted INTEGER NOT NULL
      )
    ''');
    db.execute('''
      CREATE TABLE comments (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        questionId TEXT,
        answerId TEXT,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        CHECK (questionId IS NOT NULL OR answerId IS NOT NULL)
      )
    ''');
    db.execute('''
      CREATE TABLE tags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE
      )
    ''');
    db.execute('''
      CREATE TABLE question_tags (
        questionId TEXT NOT NULL,
        tagId TEXT NOT NULL,
        PRIMARY KEY (questionId, tagId)
      )
    ''');

    userRepo = UserRepository(db);
    questionRepo = QuestionRepository(db);
    answerRepo = AnswerRepository(db);
    commentRepo = CommentRepository(db);
    tagRepo = TagRepository(db);
  });

  tearDown(() {
    db.dispose();
  });

  test('UserRepository CRUD', () {
    final user = User(id: 'u1', name: 'Test', email: 'test@mail.ru', registeredAt: DateTime.now());
    userRepo.insert(user);
    expect(userRepo.getAll().length, 1);
    expect(userRepo.getById('u1')!.name, 'Test');

    final updated = User(id: 'u1', name: 'Updated', email: 'test@mail.ru', registeredAt: DateTime.now());
    userRepo.update(updated);
    expect(userRepo.getById('u1')!.name, 'Updated');

    userRepo.delete('u1');
    expect(userRepo.getAll().length, 0);
  });

  test('TagRepository CRUD and getByName', () {
    final tag = Tag(id: 't1', name: 'dart');
    tagRepo.insert(tag);
    expect(tagRepo.getAll().length, 1);
    expect(tagRepo.getById('t1')!.name, 'dart');
    expect(tagRepo.getByName('dart')!.id, 't1');

    tagRepo.update(Tag(id: 't1', name: 'flutter'));
    expect(tagRepo.getById('t1')!.name, 'flutter');

    tagRepo.delete('t1');
    expect(tagRepo.getAll().isEmpty, true);
  });

  test('QuestionRepository with tags', () {
    final user = User(id: 'u1', name: 'Test', email: 't@t.ru', registeredAt: DateTime.now());
    userRepo.insert(user);
    final q = Question(id: 'q1', userId: 'u1', title: 'Title', content: 'Content', createdAt: DateTime.now(), views: 0);
    questionRepo.insert(q);
    final tag = Tag(id: 't1', name: 'dart');
    tagRepo.insert(tag);
    questionRepo.addTag('q1', 't1');
    final tags = questionRepo.getTagIds('q1');
    expect(tags.length, 1);
    expect(tags.first, 't1');
  });
}