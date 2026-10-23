# Java

Консольные практики на Java · *Java console coursework*

### pr8: аналитика сотрудников
- Класс `Employee`: имя, отдел, зарплата, дата найма, рейтинг эффективности
- Меню из 4 отчётов:
  1. сотрудники отдела с зарплатой выше средней;
  2. количество сотрудников с рейтингом выше 3 по отделам;
  3. самый высокооплачиваемый из нанятых за последние 2 года;
  4. средняя зарплата по отделам
- Группировка через `Map`, работа с датами через `Calendar`
- Файлы: `src/Employee.java`, `src/Main.java`

### untitled1: магазин с ролями
- Абстрактный класс `Users` и наследники `Customer` и `Employee` с разными меню
- Регистрация и авторизация
- Покупатель может только смотреть товары, сотрудник может добавлять, изменять и удалять их
- Хранение товаров в бинарном файле `products.dat` (`DataOutputStream` / `DataInputStream`)
- Экспорт и импорт в текстовый `products.txt`
- Отмена последнего действия: добавления, изменения или удаления
- Файлы: `src/*.java`

### ekz: учёт товаров (экзамен)
- Класс `Product` (количество, название, цена) реализует `Serializable`
- Меню: добавить товар, показать все, удалить по названию
- Файл: `src/main/java/org/example/Main.java`

**Запуск:** открыть папку проекта в IntelliJ IDEA и запустить `Main`.

---

## English

Java console coursework.

- **pr8 (employee analytics)**: an `Employee` class and a 4-report menu:
  1. employees of a department paid above its average;
  2. employees rated above 3, per department;
  3. top earner among those hired in the last 2 years;
  4. average salary per department.
- **untitled1 (shop with roles)**: abstract `Users` with `Customer` (view products) and `Employee` (add / edit / delete) subclasses; sign-up and login; binary storage in `products.dat`; export / import to `products.txt`; undo of the last action.
- **ekz (exam)**: `Serializable` `Product` class and a menu to add, list and delete products by name.

**Run:** open the project folder in IntelliJ IDEA and run `Main`.
