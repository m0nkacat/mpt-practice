# C#

Практики по C#: консольные приложения, WPF и ASP.NET Core · *C# coursework: console, WPF and ASP.NET Core*

Каждый проект открывается в Visual Studio через свой `.sln`.

## console/

### ConsoleApp2: двумерный массив
- Функция `z1` ищет в матрице `n × m` строку с минимальным произведением элементов и выводит её номер и само произведение
- Файл: `Program.cs`

### ConsoleApp6: учёт инструментов (ООП)
- Класс `Item` с инкапсуляцией: приватные поля, свойства только для чтения, конструктор
- Наследник `PowerTool` с мощностью, переопределение виртуального `GetDescription()`
- Статические методы: процент инструментов в аренде, список предметов, требующих обслуживания
- Консольное меню: описание предмета, загруженность, состояние
- Файл: `Program.cs`

### ConsoleApp7: строки и файлы
- Меню из 4 задач. Каждая читает первую строку из входного файла и пишет результат в выходной:
  1. разворот строки;
  2. удаление подстроки;
  3. разворот порядка слов;
  4. максимальное число в строке
- Работа с `StreamReader` и `File.WriteAllText` в UTF-8, обработка пустого файла и ошибок в числах
- Файл: `Program.cs`

### ConsoleApp8: исключения
- Деление двух введённых чисел с проверкой деления на ноль и перехватом ошибок формата ввода
- Файл: `Program.cs`

## wpf/

| Проект | Что сделано |
|---|---|
| `WpfApp1` | Обработчики кнопок: смена заголовка и фона окна, включение и отключение кнопок, изменение шрифта и цвета, скрытие элемента |
| `WpfApp2` | `DispatcherTimer` обновляет текстовое поле текущим временем каждые 3 секунды, кнопка меняет выравнивание и размер текста |
| `WpfApp3` | Кнопка увеличивает свой шрифт при каждом нажатии, на размере 24 окно краснеет, а кнопка блокируется |
| `WpfApp4` | Надпись по таймеру раз в секунду перемещается по трём позициям окна |
| `WpfApp5` | Работа с фигурами (прямоугольник, квадрат, эллипс, круг, рамка): выбор кликом, ЛКМ по цвету задаёт заливку, ПКМ — обводку, кнопка скрывает или показывает фигуру |
| `WpfApp6` | Меню «Файл / Параметры / Справка» и горячие клавиши Ctrl+C/B/T/R: циклическая смена цвета, рамки и толщины фигуры, сброс с подтверждением, строка состояния |
| `WpfApp7` | Блокнот: создать, открыть, сохранить и «сохранить как» с проверкой несохранённых изменений, отмена и повтор, буфер обмена, поиск и замена, размер шрифта, перенос по словам, печать, статистика (символы, слова, строки, абзацы) по всему тексту или выделению |
| `CalcWpf` | Калькулятор: `+ − × ÷`, √, ±, Backspace, ввод с клавиатуры с фильтром символов, ограничение в 15 цифр, форматирование результата с разделителями |
| `WpfApp_db` | CRUD категорий магазина в `DataGrid` на Entity Framework 6 (Database First) с проверкой на пустое имя и дубликаты |

## aspnet/

### pr1: формы и сессии
- ASP.NET Core MVC: страница `User_input` с формой из трёх полей, POST-обработчик сохраняет значения в `HttpContext.Session`
- Страница `Profile` читает данные из сессии и выводит их через `ViewBag`
- Файлы: `pr1/Controllers/HomeController.cs`, `pr1/Views/Home/*.cshtml`

---

## English

C# coursework: console apps, WPF and ASP.NET Core. Open each project through its `.sln` in Visual Studio.

### console/
- **ConsoleApp2**: find the row with the smallest product of elements in an `n × m` matrix.
- **ConsoleApp6**: tool inventory. Encapsulated `Item` class, `PowerTool` subclass overriding virtual `GetDescription()`, static helpers for rental share and items needing service, console menu.
- **ConsoleApp7**: four string tasks, each reading the first line of an input file and writing the result to an output file:
  1. reverse the string;
  2. remove a substring;
  3. reverse the word order;
  4. find the max number.
- **ConsoleApp8**: division of two numbers with a divide-by-zero check and format-error handling.

### wpf/
| Project | What was done |
|---|---|
| `WpfApp1` | Button handlers: change window title and background, enable/disable buttons, change font and colour, hide an element |
| `WpfApp2` | `DispatcherTimer` updates a text box with the current time every 3 s; a button changes text alignment and size |
| `WpfApp3` | A button grows its font on every click; at size 24 the window turns red and the button is disabled |
| `WpfApp4` | A label moves between three window positions every second on a timer |
| `WpfApp5` | Shapes: select by click, left-click a colour for fill, right-click for stroke, show/hide button |
| `WpfApp6` | File / Options / Help menu and Ctrl+C/B/T/R hotkeys: cycle shape colour, border and thickness, reset with confirmation, status line |
| `WpfApp7` | Notepad: new / open / save / save as with unsaved-changes check, undo/redo, clipboard, find & replace, font size, word wrap, printing, text statistics for the whole text or the selection |
| `CalcWpf` | Calculator: `+ − × ÷`, √, ±, Backspace, filtered keyboard input, 15-digit limit, formatted output |
| `WpfApp_db` | Shop categories CRUD in a `DataGrid` with Entity Framework 6 (Database First), empty-name and duplicate checks |

### aspnet/
- **pr1**: ASP.NET Core MVC form whose three fields are stored in `HttpContext.Session` and shown on the `Profile` page via `ViewBag`.
