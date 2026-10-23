# Python

Практики по Python · *Python coursework*

| Папка | Что сделано | Файлы |
|---|---|---|
| `PythonProject` | Проверка палиндрома без учёта знаков препинания и пробелов, проверка «перевёртышей» (кот / ток), тесты на pytest | `main.py`, `test_main.py` |
| `pr3` | Крестики-нолики в консоли: поле от 3×3 до 9×9, режим против бота (случайные ходы), жребий первого хода, проверка ввода, сохранение итогов в файл | `main.py` |
| `pr4` | CSV и JSON: запись таблицы животных в CSV и конвертация в JSON, добавление столбца «Зарплата» к таблице сотрудников по словарю должностей | `kaif333.py` |
| `pr11` | Библиотека на ООП: абстрактный `Person`, наследники `User` и `Librarian`. Библиотекарь добавляет и удаляет книги и читателей, читатель берёт и возвращает книги. Всё сохраняется в `library.pkl` через pickle | `main.py` |
| `praktos1` | Калькулятор всех операторов Python: арифметика, сравнения, логические, побитовые, `in`, `is`, с проверкой деления на ноль | `hi.py` |
| `warehouse_tkinter` | Рефакторинг складского приложения: классы `Product`, `Warehouse` и `WarehouseApp`, GUI на Tkinter (добавить, показать, удалить, обновить количество, общая стоимость) | `refactor.py` |
| `image_processing` | Поворот изображений и перевод в оттенки серого (Pillow), сравнение времени последовательной обработки и параллельной через `multiprocessing.Pool` | `app.py` |
| `socket_server` | Многопользовательский чат: сервер с потоком на каждого клиента, рассылка сообщений всем, `threading.Lock`; клиент с отдельными потоками приёма и отправки | `server.py`, `client1.py` |
| `devops` | Flask-приложение с JSON-эндпоинтом, тест через `test_client`, столбчатая диаграмма HTTP-запросов (Seaborn) | `app.py`, `test_app.py`, `visualization.py` |
| `weather_api` | Запрос погоды через OpenWeather API: обработка ошибок 401 и 404, таймаута и ошибок сети, вывод температуры, влажности и ветра | `weather_app.py` |

### Командная практика: [short-higurashi-whentheycry-ch1](https://github.com/sdformeky/short-higurashi-whentheycry-ch1)
- Консольная текстовая игра по первой главе Higurashi no Naku Koro ni, сделана в команде
- Сюжет со сценами и выбором действий, свой саундтрек для каждой локации (`pygame.mixer`)
- Механики: инвентарь, здоровье и лечение, атака
- Мини-игры: блэкджек против персонажей и фестивальная игра на кубике d20
- Сборка в `.exe` через PyInstaller (`higurashi.spec`)
- Код лежит в отдельном репозитории (ссылка в заголовке)

**Запуск:** `python <файл>.py`, тесты — `pytest`.
- Зависимости: `pillow` для `image_processing`, `flask`, `seaborn` и `matplotlib` для `devops`, `requests` для `weather_api`.
- Для `weather_api` нужна переменная `OPENWEATHER_API_KEY`.

---

## English

| Folder | What was done |
|---|---|
| `PythonProject` | Palindrome check ignoring punctuation and spaces, reversed-word check (кот / ток), pytest tests |
| `pr3` | Console tic-tac-toe: 3×3 to 9×9 board, random-move bot, coin toss for the first move, input validation, results saved to a file |
| `pr4` | CSV ↔ JSON: animal table written to CSV and converted to JSON; a salary column added to an employee table from a position map |
| `pr11` | OOP library: abstract `Person`, `User` and `Librarian`; librarians manage books and readers, readers borrow and return books; pickle persistence |
| `praktos1` | Calculator for every Python operator (arithmetic, comparison, logical, bitwise, `in`, `is`) with divide-by-zero checks |
| `warehouse_tkinter` | Refactored warehouse app: `Product`, `Warehouse`, `WarehouseApp` classes and a Tkinter GUI |
| `image_processing` | Pillow rotation and grayscale conversion; sequential vs `multiprocessing.Pool` timing |
| `socket_server` | Multi-user chat: thread per client, broadcast, `threading.Lock`; client with separate receive / send threads |
| `devops` | Flask JSON endpoint, `test_client` test, Seaborn bar chart of HTTP requests |
| `weather_api` | OpenWeather API client handling 401, 404, timeouts and network errors |

**Team assignment: [short-higurashi-whentheycry-ch1](https://github.com/sdformeky/short-higurashi-whentheycry-ch1)**: a console text game based on chapter 1 of Higurashi no Naku Koro ni.
- Scenes with player choices and per-location music via `pygame.mixer`.
- Mechanics: inventory, health and healing, attacks.
- Mini-games: blackjack against characters and a d20 festival game.
- Packaged as an `.exe` with PyInstaller.

**Run:** `python <file>.py`, tests with `pytest`.
- Dependencies: `pillow` for `image_processing`; `flask`, `seaborn` and `matplotlib` for `devops`; `requests` for `weather_api`.
- `weather_api` needs the `OPENWEATHER_API_KEY` variable.
