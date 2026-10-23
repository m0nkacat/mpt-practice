import 'question.dart';
import 'enums.dart';
import 'storage.dart';

final List<Question> questions = [];
int _nextId = 1;
int lastId = 0;

int get count => questions.length;

void loadQuestions(List<Question> loaded) {
  questions.clear();
  questions.addAll(loaded);
  for (final q in questions) {
    if (q.id >= _nextId) _nextId = q.id + 1;
  }
  if (questions.isNotEmpty) lastId = questions.last.id;
}

Future<Question> addQuestion(
    String title, String body, String author, dynamic category) async {
  final q = Question(
    id: _nextId++,
    title: title,
    body: body,
    author: author,
    category: category,
    createdAt: DateTime.now(),
  );
  questions.add(q);
  lastId = q.id;
  await saveToFile(questions);
  return q;
}

Future<bool> deleteQuestion(int id) async {
  final idx = questions.indexWhere((q) => q.id == id);
  if (idx == -1) return false;
  questions.removeAt(idx);
  await saveToFile(questions);
  return true;
}

Question? findById(int id) {
  try {
    return questions.firstWhere((q) => q.id == id);
  } catch (_) {
    return null;
  }
}

Future<void> updateQuestion(Question q) async {
  final idx = questions.indexWhere((x) => x.id == q.id);
  if (idx != -1) {
    questions[idx] = q;
    await saveToFile(questions);
  }
}

List<Question> search(String query) {
  final q = query.toLowerCase();
  return questions.where((x) =>
    x.title.toLowerCase().contains(q) ||
    x.body.toLowerCase().contains(q) ||
    x.author.toLowerCase().contains(q)
  ).toList();
}

List<Question> sorted(String by, bool desc) {
  final list = List<Question>.from(questions);
  list.sort((a, b) {
    int c;
    if (by == 'title') c = a.title.compareTo(b.title);
    else if (by == 'views') c = a.views.compareTo(b.views);
    else if (by == 'date') c = a.createdAt.compareTo(b.createdAt);
    else c = a.id.compareTo(b.id);
    return desc ? -c : c;
  });
  return list;
}

Map<String, dynamic> getStats() {
  int totalViews = 0;
  int pinned = 0;
  int withAnswer = 0;
  final byCategory = <String, int>{};
  final byStatus = <String, int>{};

  for (final q in questions) {
    totalViews += q.views;
    if (q.pinned) pinned++;
    if (q.bestAnswer != null) withAnswer++;
    byCategory[q.category.name] = (byCategory[q.category.name] ?? 0) + 1;
    byStatus[q.status.name] = (byStatus[q.status.name] ?? 0) + 1;
  }

  return {
    'total': questions.length,
    'totalViews': totalViews,
    'pinned': pinned,
    'withAnswer': withAnswer,
    'byCategory': byCategory,
    'byStatus': byStatus,
  };
}

Future<void> seed() async {
  if (questions.isNotEmpty) return;
  await addQuestion('Как выучить Dart с нуля?',
      'Посоветуйте лучшие ресурсы для изучения языка Dart.', 'Алексей',
      Category.technology);
  await addQuestion('Что такое null safety в Dart?',
      'Объясните концепцию null safety и зачем она нужна.', 'Мария',
      Category.technology);
  await addQuestion('Кто выиграл ЧМ по футболу в 2022?',
      'Хочу узнать результаты последнего чемпионата мира.', 'Игорь',
      Category.sport);
  await addQuestion('Почему небо голубое?',
      'Объясните физическое явление голубого цвета неба.', 'Анна',
      Category.science);
  await addQuestion('Лучшие фильмы 2024 года?',
      'Подскажите, какие фильмы стоит посмотреть в 2024.', 'Дмитрий',
      Category.entertainment);
}
