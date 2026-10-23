import '../lib/storage.dart';
import '../lib/collection.dart';
import '../lib/logger.dart';
import '../lib/menu.dart';

Future<void> main() async {
  await initLogger();

  try {
    final loaded = await loadFromFile();
    loadQuestions(loaded);
  } catch (e) {
    log(Action.start, e.toString());
  }

  await seed();

  log(Action.start, 'Приложение запущено');
  await runMenu();
}