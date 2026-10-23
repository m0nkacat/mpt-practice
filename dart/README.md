# Dart

Консольные приложения на Dart · *Dart console apps*

### qa_app2: Q&A-платформа с бинарным хранением
- Сущность `Question` с enum-полями `Category` и `Status`, nullable-полем `bestAnswer` и датой создания
- Меню: добавить, удалить, редактировать, поиск, показать все, статистика, логи, отчёт
- Собственный бинарный формат файла `data.bin` (int32 и float64 big-endian, строки с длиной) и резервная копия `data_backup.bin`
- Логирование в отдельном изоляте (`Isolate`) в файл `logs.txt`
- Подробное описание формата и структуры — в `qa_app2/README.md`
- Запуск: `dart run bin/main.dart`

### dart_bd: Q&A-платформа на SQLite
- Пользователи, вопросы, ответы, комментарии, теги. Для каждой сущности есть CRUD: добавить, список, найти по ID, обновить, удалить
- Слоистая архитектура:
  - `domain`: модели и валидаторы, не зависят от БД;
  - `data`: SQLite, создание таблиц, репозитории;
  - `cli`: меню и ввод с повторными попытками
- Валидация обязательных строк и положительных чисел
- Тесты на каждый слой: сериализация моделей, репозитории на временной БД, валидаторы
- Подробности — в `dart_bd/src/README.md`
- Запуск: `cd dart_bd/src && dart run`, тесты — `dart test`

---

## English

- **qa_app2**: console Q&A app.
  - A `Question` entity with enums, a nullable best answer and a creation date.
  - Add / delete / edit / search / list / stats / logs / report menu.
  - Custom big-endian binary format in `data.bin` with a backup copy.
  - Logging in a separate `Isolate`.
- **dart_bd**: Q&A app on SQLite.
  - CRUD for users, questions, answers, comments and tags.
  - `domain` / `data` / `cli` layers, input validators.
  - Tests for every layer.
