# Data Science

Практики по анализу данных · *Data analysis coursework*

`Python` `NumPy` `Pandas` `Jupyter` `Excel`

### ПР1: NumPy и описательная статистика
- Вариант 2: количество шагов за 30 дней (шагомер)
- Среднее, медиана, минимум, максимум, дисперсия, стандартное отклонение, размах
- Перцентили (25, 50, 75, 90, 99), квартили, межквартильный размах
- Поиск выбросов по правилу `Q1 − 1,5·IQR` и `Q3 + 1,5·IQR`, сравнение среднего с выбросами и без них
- Индивидуальный вопрос: доля дней с менее чем 8000 шагов
- Работа с матрицей: `reshape` в 3×5, суммы по строкам и столбцам, статистика по всей матрице
- Файлы: `ПР1/ПР1.ipynb`, `ПР1/ПР1.html` (готовый просмотр)

### ПР2: Excel
- Анализ планов и исполнения бюджета по регионам
- Листы:
  - заполнение пропусков медианами;
  - справочник территорий с федеральными округами;
  - аналитика (средний факт по регионам, итоговые показатели, исполнение плана);
  - сводная таблица по статьям доходов;
  - диаграмма
- Файл: `ПР2/ПР2 (без исходных данных).xlsx`. Исходные данные не включены из-за размера

### ПР3: EDA на Pandas
- Вариант 4: продажи видеоигр (датасет VGChartz, 2024)
- Обзор данных через `info()`, `describe()`, `nunique()`, описание столбцов
- Пропуски: категориальные заполнены `no data`, числовые — медианой, с обоснованием
- Дубликаты: проверка полных совпадений, разбор повторов по названию (одна игра на разных платформах) и удаление настоящих дублей
- Асимметрия и коэффициент вариации продаж с интерпретацией
- Выборки через `query()`, `sort_values()`, `loc`, `iloc`, группировка по жанрам, топ-5 игр
- Файлы: `ПР3/ПР3.ipynb`, `ПР3/ПР3.html`, `ПР3/data/vg_data_dictionary.csv`. Сам датасет не включён из-за размера

---

## English

- **PR1 (NumPy)**: step-counter data.
  - Descriptive statistics, percentiles and the IQR.
  - Outlier detection and the mean with / without outliers.
  - Matrix operations with `reshape`.
- **PR2 (Excel)**: regional budget plan vs execution.
  - Median gap filling and a territory reference.
  - Analytics sheet, pivot table and a chart.
- **PR3 (Pandas EDA)**: VGChartz 2024 video game sales.
  - Data overview and missing-value handling with reasoning.
  - Duplicate analysis.
  - Skewness and coefficient of variation.
  - `query` / `loc` / `iloc` selections, grouping by genre, top-5 games.

HTML exports can be viewed without Jupyter. Large source datasets are not included.
