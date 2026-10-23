import 'dart:io';
import 'package:dart_bd/dart_bd.dart';

class Menu {
  final MailruDatabase db;
  Menu(this.db);

  void run() {
    while (true) {
      print('1. Пользователи');
      print('2. Вопросы');
      print('3. Ответы');
      print('4. Комментарии');
      print('5. Теги');
      print('6. Показать всё из БД');
      print('0. Выход');
      stdout.write('Выберите действие: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          _userMenu();
          break;
        case '2':
          _questionMenu();
          break;
        case '3':
          _answerMenu();
          break;
        case '4':
          _commentMenu();
          break;
        case '5':
          _tagMenu();
          break;
        case '6':
          _showAll();
          break;
        case '0':
          return;
        default:
          print('Неверный ввод');
      }
    }
  }

  void _userMenu() {
    while (true) {
      print('1. Добавить');
      print('2. Список всех');
      print('3. Найти по ID');
      print('4. Обновить');
      print('5. Удалить');
      print('0. Назад');
      stdout.write('Выберите: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          final id = InputHelper.askString('ID пользователя');
          final name = InputHelper.askString('Имя');
          final email = InputHelper.askString('Email');
          final reg = InputHelper.askDate('Дата регистрации');
          db.userRepo.insert(User(id: id, name: name, email: email, registeredAt: reg));
          print('Пользователь добавлен');
          break;
        case '2':
          final users = db.userRepo.getAll();
          if (users.isEmpty) print('Нет пользователей');
          else for (var u in users) print('  $u');
          break;
        case '3':
          final id = InputHelper.askString('ID');
          final u = db.userRepo.getById(id);
          print(u ?? 'Не найден');
          break;
        case '4':
          final id = InputHelper.askString('ID');
          final old = db.userRepo.getById(id);
          if (old == null) {
            print('Не найден');
            break;
          }
          final name = InputHelper.askString('Новое имя (${old.name})');
          final email = InputHelper.askString('Новый email (${old.email})');
          final reg = InputHelper.askDate('Новая дата рег. (${old.registeredAt})');
          db.userRepo.update(User(id: id, name: name, email: email, registeredAt: reg));
          print('Обновлён');
          break;
        case '5':
          final id = InputHelper.askString('ID');
          db.userRepo.delete(id);
          print('Удалён');
          break;
        case '0':
          return;
        default:
          print('Неверно');
      }
    }
  }

  void _questionMenu() {
    while (true) {
      print('1. Добавить');
      print('2. Список всех');
      print('3. Найти по ID');
      print('4. Обновить');
      print('5. Удалить');
      print('0. Назад');
      stdout.write('Выберите: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          final id = InputHelper.askString('ID вопроса');
          final userId = InputHelper.askString('ID автора');
          final title = InputHelper.askString('Заголовок');
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания');
          final views = InputHelper.askPositiveInt('Просмотры');
          db.questionRepo.insert(Question(
            id: id,
            userId: userId,
            title: title,
            content: content,
            createdAt: createdAt,
            views: views,
          ));
          print('Вопрос добавлен');
          break;
        case '2':
          final qs = db.questionRepo.getAll();
          if (qs.isEmpty) print('Нет вопросов');
          else for (var q in qs) print('  $q');
          break;
        case '3':
          final id = InputHelper.askString('ID');
          final q = db.questionRepo.getById(id);
          print(q ?? 'Не найден');
          break;
        case '4':
          final id = InputHelper.askString('ID');
          final old = db.questionRepo.getById(id);
          if (old == null) {
            print('Не найден');
            break;
          }
          final userId = InputHelper.askString('ID автора (${old.userId})');
          final title = InputHelper.askString('Заголовок (${old.title})');
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания (${old.createdAt})');
          final views = InputHelper.askPositiveInt('Просмотры (${old.views})');
          db.questionRepo.update(Question(
            id: id,
            userId: userId,
            title: title,
            content: content,
            createdAt: createdAt,
            views: views,
          ));
          print('Обновлён');
          break;
        case '5':
          final id = InputHelper.askString('ID');
          db.questionRepo.delete(id);
          print('Удалён');
          break;
        case '0':
          return;
        default:
          print('Неверно');
      }
    }
  }

  void _answerMenu() {
    while (true) {
      print('1. Добавить');
      print('2. Список всех');
      print('3. Найти по ID');
      print('4. Обновить');
      print('5. Удалить');
      print('0. Назад');
      stdout.write('Выберите: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          final id = InputHelper.askString('ID ответа');
          final userId = InputHelper.askString('ID автора');
          final questionId = InputHelper.askString('ID вопроса');
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания');
          final isAccepted = InputHelper.askString('Принят? (да/нет)').toLowerCase() == 'да';
          db.answerRepo.insert(Answer(
            id: id,
            userId: userId,
            questionId: questionId,
            content: content,
            createdAt: createdAt,
            isAccepted: isAccepted,
          ));
          print('Ответ добавлен');
          break;
        case '2':
          final as = db.answerRepo.getAll();
          if (as.isEmpty) print('Нет ответов');
          else for (var a in as) print('  $a');
          break;
        case '3':
          final id = InputHelper.askString('ID');
          final a = db.answerRepo.getById(id);
          print(a ?? 'Не найден');
          break;
        case '4':
          final id = InputHelper.askString('ID');
          final old = db.answerRepo.getById(id);
          if (old == null) {
            print('Не найден');
            break;
          }
          final userId = InputHelper.askString('ID автора (${old.userId})');
          final questionId = InputHelper.askString('ID вопроса (${old.questionId})');
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания (${old.createdAt})');
          final isAccepted = InputHelper.askString('Принят? (да/нет)').toLowerCase() == 'да';
          db.answerRepo.update(Answer(
            id: id,
            userId: userId,
            questionId: questionId,
            content: content,
            createdAt: createdAt,
            isAccepted: isAccepted,
          ));
          print('Обновлён');
          break;
        case '5':
          final id = InputHelper.askString('ID');
          db.answerRepo.delete(id);
          print('Удалён');
          break;
        case '0':
          return;
        default:
          print('Неверно');
      }
    }
  }

  void _commentMenu() {
    while (true) {
      print('1. Добавить');
      print('2. Список всех');
      print('3. Найти по ID');
      print('4. Обновить');
      print('5. Удалить');
      print('0. Назад');
      stdout.write('Выберите: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          final id = InputHelper.askString('ID комментария');
          final userId = InputHelper.askString('ID автора');
          final target = InputHelper.askString('К чему относится? (question/answer)').toLowerCase();
          String? questionId, answerId;
          if (target == 'question') {
            questionId = InputHelper.askString('ID вопроса');
          } else if (target == 'answer') {
            answerId = InputHelper.askString('ID ответа');
          } else {
            print('Ошибка: надо написать question или answer');
            break;
          }
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания');
          db.commentRepo.insert(Comment(
            id: id,
            userId: userId,
            questionId: questionId,
            answerId: answerId,
            content: content,
            createdAt: createdAt,
          ));
          print('✓ Комментарий добавлен');
          break;
        case '2':
          final cs = db.commentRepo.getAll();
          if (cs.isEmpty) print('Нет комментариев');
          else for (var c in cs) print('  $c');
          break;
        case '3':
          final id = InputHelper.askString('ID');
          final c = db.commentRepo.getById(id);
          print(c ?? 'Не найден');
          break;
        case '4':
          final id = InputHelper.askString('ID');
          final old = db.commentRepo.getById(id);
          if (old == null) {
            print('Не найден');
            break;
          }
          final userId = InputHelper.askString('ID автора (${old.userId})');
          final content = InputHelper.askString('Содержание');
          final createdAt = InputHelper.askDate('Дата создания (${old.createdAt})');
          db.commentRepo.update(Comment(
            id: id,
            userId: userId,
            questionId: old.questionId,
            answerId: old.answerId,
            content: content,
            createdAt: createdAt,
          ));
          print('Обновлён');
          break;
        case '5':
          final id = InputHelper.askString('ID');
          db.commentRepo.delete(id);
          print('Удалён');
          break;
        case '0':
          return;
        default:
          print('Неверно');
      }
    }
  }

  void _tagMenu() {
    while (true) {
      print('\n--- УПРАВЛЕНИЕ ТЕГАМИ ---');
      print('1. Добавить');
      print('2. Список всех');
      print('3. Найти по ID');
      print('4. Обновить');
      print('5. Удалить');
      print('6. Привязать тег к вопросу');
      print('0. Назад');
      stdout.write('Выберите: ');
      final choice = stdin.readLineSync()?.trim();
      switch (choice) {
        case '1':
          final id = InputHelper.askString('ID тега');
          final name = InputHelper.askString('Название');
          db.tagRepo.insert(Tag(id: id, name: name));
          print('Тег добавлен');
          break;
        case '2':
          final ts = db.tagRepo.getAll();
          if (ts.isEmpty) print('Нет тегов');
          else for (var t in ts) print('  $t');
          break;
        case '3':
          final id = InputHelper.askString('ID');
          final t = db.tagRepo.getById(id);
          print(t ?? 'Не найден');
          break;
        case '4':
          final id = InputHelper.askString('ID');
          final old = db.tagRepo.getById(id);
          if (old == null) {
            print('Не найден');
            break;
          }
          final name = InputHelper.askString('Новое название (${old.name})');
          db.tagRepo.update(Tag(id: id, name: name));
          print('Обновлён');
          break;
        case '5':
          final id = InputHelper.askString('ID');
          db.tagRepo.delete(id);
          print('Удалён');
          break;
        case '6':
          final questionId = InputHelper.askString('ID вопроса');
          final tagId = InputHelper.askString('ID тега');
          db.questionRepo.addTag(questionId, tagId);
          print('Тег привязан к вопросу');
          break;
        case '0':
          return;
        default:
          print('Неверно');
      }
    }
  }

  void _showAll() {
    for (var u in db.userRepo.getAll()) print('  $u');
    for (var q in db.questionRepo.getAll()) print('  $q');
    for (var a in db.answerRepo.getAll()) print('  $a');
    for (var c in db.commentRepo.getAll()) print('  $c');
    for (var t in db.tagRepo.getAll()) print('  $t');
    for (var q in db.questionRepo.getAll()) {
      final tagIds = db.questionRepo.getTagIds(q.id);
      if (tagIds.isNotEmpty) {
        print('  Вопрос "${q.title}" имеет теги: ${tagIds.join(', ')}');
      }
    }
  }
}