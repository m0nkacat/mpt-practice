# Q&A Платформа

Консольное приложение на Dart для управления вопросами и ответами.

## Запуск

dart run bin/main.dart

## Сущность Question

- id — int, автоинкремент
- title — String
- body — String
- author — String
- views — int
- pinned — bool
- category — enum Category (general, technology, science, sport, entertainment, other)
- status — enum Status (open, answered, closed)
- bestAnswer — String?, nullable
- createdAt — DateTime

## Формат data.bin

Первые 4 байта — количество записей (int32 big-endian). Далее каждая запись: 4 байта длины + байты. Внутри записи: id (4), title (4+N), body (4+N), author (4+N), views (4), pinned (1), category (1), status (1), bestAnswer (1 флаг + 4+N), createdAt (8, float64 big-endian).

## Структура

- bin/main.dart — точка входа
- lib/enums.dart — Category, Status
- lib/question.dart — модель, сериализация
- lib/storage.dart — чтение/запись data.bin
- lib/logger.dart — логирование через изолят
- lib/collection.dart — коллекция и операции
- lib/menu.dart — меню, отчёт