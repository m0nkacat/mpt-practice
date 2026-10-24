# Dart

Консольные приложения на Dart · *Dart console apps*

### basics: ПР1–ПР4
Первые практики по Dart, каждая в своём файле в `basics/bin/`. Запуск: `cd basics && dart pub get && dart run bin/<файл>.dart`.

| Файл | Что сделано |
|---|---|
| `pr1_calculator.dart` | Калькулятор с меню из 16 операций: арифметика, `~/`, `%`, степень, сравнения, логические операторы |
| `pr2_grades.dart` | Ведомость оценок на `Map<String, Map<String, int>>`. Меню из 8 запросов: разделить студентов на отличников, хорошистов и остальных; посчитать оценки; найти студентов с пятёрками по предметам; найти предметы без двоек; найти предмет с наибольшим числом двоек и другие |
| `pr3_unicode.dart` | Строки и Unicode: случайное настроение с эмодзи, код символа `U+…`, разбор сложных эмодзи на 16-битные единицы, кодовые точки (`runes`) и видимые символы (пакет `characters`) |
| `pr4_oop.dart` | ООП, 11 задач: классы и взаимодействие объектов (кружка и человек, шкаф, гриф с блинами), конвертер валют, дженерик `Garage<T>`, перегрузка операторов, `enum` состояний автомобиля, абстрактный `Shape` с наследниками и поиском фигуры с наибольшей площадью, перевод систем счисления |

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

- **basics (PR1–PR4)**: the first Dart assignments, one file each in `basics/bin/`.
  - A 16-operation calculator.
  - A grade book on nested maps with an 8-query menu.
  - Strings and Unicode: runes, code points and grapheme clusters via `characters`.
  - 11 OOP tasks: classes, generics, operator overloading, enums, an abstract `Shape` hierarchy.

- **qa_app2**: console Q&A app.
  - A `Question` entity with enums, a nullable best answer and a creation date.
  - Add / delete / edit / search / list / stats / logs / report menu.
  - Custom big-endian binary format in `data.bin` with a backup copy.
  - Logging in a separate `Isolate`.
- **dart_bd**: Q&A app on SQLite.
  - CRUD for users, questions, answers, comments and tags.
  - `domain` / `data` / `cli` layers, input validators.
  - Tests for every layer.
