import 'dart:io';
import 'dart:isolate';
import 'enums.dart';
import 'collection.dart';
import 'logger.dart';
import 'storage.dart';

Future<void> runMenu() async {
  while (true) {
    print('');
    print('1. Добавить вопрос');
    print('2. Удалить вопрос');
    print('3. Редактировать вопрос');
    print('4. Поиск');
    print('5. Показать все');
    print('6. Статистика');
    print('7. Логи');
    print('8. Отчёт');
    print('0. Выход');
    stdout.write('> ');

    final choice = stdin.readLineSync()?.trim() ?? '';

    if (choice == '1') {
      await _add();
    } else if (choice == '2') {
      await _delete();
    } else if (choice == '3') {
      await _edit();
    } else if (choice == '4') {
      await _search();
    } else if (choice == '5') {
      await _list();
    } else if (choice == '6') {
      await _stats();
    } else if (choice == '7') {
      await _logs();
    } else if (choice == '8') {
      await _report();
    } else if (choice == '0') {
      log(Action.exit, 'Приложение завершено');
      await Future.delayed(const Duration(milliseconds: 200));
      stopLogger();
      print('Выход.');
      return;
    } else {
      print('Нет такого пункта.');
    }
  }
}

Future<void> _add() async {
  stdout.write('Заголовок: ');
  final title = stdin.readLineSync() ?? '';
  if (title.trim().isEmpty) {
    print('Пустой заголовок.');
    log(Action.error, 'Пустой заголовок при добавлении');
    return;
  }
  stdout.write('Текст: ');
  final body = stdin.readLineSync() ?? '';
  if (body.trim().isEmpty) {
    print('Пустой текст.');
    log(Action.error, 'Пустой текст при добавлении');
    return;
  }
  stdout.write('Автор: ');
  final author = stdin.readLineSync() ?? '';
  if (author.trim().isEmpty) {
    print('Пустой автор.');
    log(Action.error, 'Пустое имя при добавлении');
    return;
  }
  final cat = _pickCategory();
  final q = await addQuestion(title.trim(), body.trim(), author.trim(), cat);
  print('Добавлен ID=${q.id}');
  log(Action.add, 'Добавлен вопрос ID=${q.id}: ${q.title}');
}

Future<void> _delete() async {
  stdout.write('ID: ');
  final id = int.tryParse(stdin.readLineSync()?.trim() ?? '');
  if (id == null) { print('Некорректный ID.'); return; }
  final ok = await deleteQuestion(id);
  if (ok) {
    print('Удалён.');
    log(Action.delete, 'Удалён вопрос ID=$id');
  } else {
    print('Не найден.');
    log(Action.error, 'Попытка удалить несуществующий ID=$id');
  }
}

Future<void> _edit() async {
  stdout.write('ID: ');
  final id = int.tryParse(stdin.readLineSync()?.trim() ?? '');
  if (id == null) { print('Некорректный ID.'); return; }

  final q = findById(id);
  if (q == null) {
    print('Не найден.');
    log(Action.error, 'Попытка редактировать несуществующий ID=$id');
    return;
  }

  print('Заголовок: ${q.title}');
  stdout.write('Новый (Enter = оставить): ');
  final title = stdin.readLineSync() ?? '';
  if (title.trim().isNotEmpty) q.title = title.trim();

  print('Текст: ${q.body}');
  stdout.write('Новый (Enter = оставить): ');
  final body = stdin.readLineSync() ?? '';
  if (body.trim().isNotEmpty) q.body = body.trim();

  print('Статус: ${q.status.name}');
  stdout.write('open/answered/closed (Enter = оставить): ');
  final st = stdin.readLineSync()?.trim() ?? '';
  if (st.isNotEmpty) {
    try {
      q.status = Status.values.firstWhere((s) => s.name == st);
    } catch (_) {
      print('Неизвестный статус, оставляю старый.');
    }
  }

  stdout.write('Лучший ответ (Enter = оставить, clear = убрать): ');
  final ans = stdin.readLineSync() ?? '';
  if (ans == 'clear') q.bestAnswer = null;
  else if (ans.trim().isNotEmpty) q.bestAnswer = ans.trim();

  await updateQuestion(q);
  print('Сохранено.');
  log(Action.edit, 'Отредактирован ID=$id');
}

Future<void> _search() async {
  stdout.write('Запрос: ');
  final query = stdin.readLineSync()?.trim() ?? '';
  if (query.isEmpty) { print('Пустой запрос.'); return; }
  log(Action.search, 'Поиск: $query');
  final res = search(query);
  if (res.isEmpty) { print('Ничего не найдено.'); return; }
  print('Найдено: ${res.length}');
  for (final q in res) _printShort(q);
}

Future<void> _list() async {
  print('Сортировка: 1=ID  2=заголовок  3=просмотры  4=дата');
  stdout.write('> ');
  final s = stdin.readLineSync()?.trim() ?? '';
  String by = 'id';
  if (s == '2') by = 'title';
  else if (s == '3') by = 'views';
  else if (s == '4') by = 'date';

  stdout.write('По убыванию? y/N: ');
  final desc = (stdin.readLineSync()?.trim() ?? '') == 'y';

  final list = sorted(by, desc);
  log(Action.list, 'Список (${list.length} шт.)');

  if (list.isEmpty) { print('Список пуст.'); return; }
  for (final q in list) _printShort(q);

  stdout.write('ID для просмотра (Enter = назад): ');
  final id = int.tryParse(stdin.readLineSync()?.trim() ?? '');
  if (id != null) await _detail(id);
}

Future<void> _detail(int id) async {
  final q = findById(id);
  if (q == null) { print('Не найден.'); return; }
  q.views++;
  await updateQuestion(q);
  print('');
  print('[${q.id}] ${q.title}');
  print('Автор: ${q.author}');
  print('Категория: ${q.category.name}');
  print('Статус: ${q.status.name}');
  print('Просмотры: ${q.views}');
  print('Дата: ${q.createdAt.toLocal()}');
  print('');
  print(q.body);
  if (q.bestAnswer != null) {
    print('');
    print('Лучший ответ: ${q.bestAnswer}');
  }
}

Future<void> _stats() async {
  log(Action.stats, 'Просмотр статистики');
  final s = getStats();
  print('Всего: ${s['total']}');
  print('Просмотров: ${s['totalViews']}');
  print('Закреплённых: ${s['pinned']}');
  print('С ответом: ${s['withAnswer']}');
  print('По категориям:');
  (s['byCategory'] as Map<String, int>).forEach((k, v) => print('  $k: $v'));
  print('По статусу:');
  (s['byStatus'] as Map<String, int>).forEach((k, v) => print('  $k: $v'));
}

Future<void> _logs() async {
  log(Action.viewLogs, 'Просмотр логов');
  stdout.write('Сколько строк? (Enter = 20): ');
  final n = int.tryParse(stdin.readLineSync()?.trim() ?? '') ?? 20;
  await Future.delayed(const Duration(milliseconds: 150));
  final lines = getLastLines(n);
  if (lines.isEmpty) { print('Логи пусты.'); return; }
  for (final l in lines) print(l);
}

Future<void> _report() async {
  print('Генерирую отчёт...');
  log(Action.report, 'Запуск отчёта в изоляте');

  await copyFile('data.bin', 'data_backup.bin');

  final rp = ReceivePort();
  final data = questions.map((q) => q.toMap()).toList();
  await Isolate.spawn(_reportIsolate, [rp.sendPort, data]);
  final result = await rp.first as String;
  print(result);

  log(Action.report, 'Отчёт готов');
}

void _reportIsolate(List<dynamic> args) {
  final sp = args[0] as SendPort;
  final data = args[1] as List<dynamic>;

  final buf = StringBuffer();
  buf.writeln('--- Отчёт ---');
  buf.writeln('Вопросов: ${data.length}');

  int views = 0, pinned = 0, withAns = 0;
  final byCat = <String, int>{};
  final bySt = <String, int>{};

  for (final m in data) {
    final map = m as Map<String, dynamic>;
    views += map['views'] as int;
    if (map['pinned'] as bool) pinned++;
    if (map['bestAnswer'] != null) withAns++;
    final cat = Category.values[map['category'] as int].name;
    final st = Status.values[map['status'] as int].name;
    byCat[cat] = (byCat[cat] ?? 0) + 1;
    bySt[st] = (bySt[st] ?? 0) + 1;
  }

  buf.writeln('Просмотров: $views');
  buf.writeln('Закреплённых: $pinned');
  buf.writeln('С ответом: $withAns');
  buf.writeln('Категории:');
  byCat.forEach((k, v) => buf.writeln('  $k: $v'));
  buf.writeln('Статусы:');
  bySt.forEach((k, v) => buf.writeln('  $k: $v'));
  buf.writeln('-------------');

  sp.send(buf.toString());
}

void _printShort(dynamic q) {
  print('[${q.id}] ${q.title} | ${q.author} | ${_statusName(q.status)} | ${q.views} просм.');
}

Category _pickCategory() {
  for (int i = 0; i < Category.values.length; i++) {
    print('${i + 1}. ${Category.values[i].name}');
  }
  stdout.write('Категория: ');
  final idx = (int.tryParse(stdin.readLineSync()?.trim() ?? '') ?? 1) - 1;
  if (idx < 0 || idx >= Category.values.length) return Category.general;
  return Category.values[idx];
}

String _statusName(Status s) {
  switch (s) {
    case Status.open: return 'open';
    case Status.answered: return 'answered';
    case Status.closed: return 'closed';
  }
}

String _categoryName(Category c) {
  switch (c) {
    case Category.general: return 'general';
    case Category.technology: return 'technology';
    case Category.science: return 'science';
    case Category.sport: return 'sport';
    case Category.entertainment: return 'entertainment';
    case Category.other: return 'other';
  }
}