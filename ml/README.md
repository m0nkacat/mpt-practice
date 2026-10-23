# ML

Практики по машинному обучению · *Machine learning coursework*

`Python` `Pandas` `NumPy` `Seaborn` `Matplotlib` `Jupyter`

Датасет: статистика матчей VCT (Valorant Champions Tour).

### ПР1: разведочный анализ (EDA)
- Загрузка, исследование и обработка датасета, выбор целевой переменной (`Team`) с обоснованием
- Личная цель: разобрать сезон команды FNATIC и понять, почему она проиграла гранд-финалы
- Анализ по файлам:
  - `scores.csv`: результаты матчей и путь к финалам;
  - `draft_phase.csv`: драфт карт;
  - `maps_scores.csv`: процент побед на каждой карте;
  - `overview.csv`: статистика игроков за сезон и в финалах;
  - `win_loss_methods_round_number.csv`: способы выигрыша раундов, пистолетные раунды;
  - `eco_rounds.csv`: экономика, сравнение с Paper Rex
- Выводы по каждому разделу и итог по личной цели
- Файлы: `iypnb/Практическая_работа_№1_…+ свое.ipynb`, `html/…` (готовый просмотр)

### ПР2: графики
- Работа на датасете, обработанном в ПР1 (`datasets/processed/overview_processed.csv`)
- Графики Seaborn:
  - `countplot`: сколько раз сыграна каждая карта;
  - `barplot`: средние значения показателей;
  - `boxplot`: распределение и выбросы;
  - `heatmap`: корреляция признаков;
  - `pairplot`: попарные зависимости;
  - дополнительно `histplot` рейтинга, boxplot рейтинга по картам и средний рейтинг по агентам
- К каждому графику: зачем он нужен, какие команды использованы, ответ с выводами
- Файлы: `iypnb/Практическая_работа_№2_….ipynb`, `html/…`

Папка `datasets/`: обработанные CSV (`processed/`) и учебный датасет (`forlessons/`). Исходный архив VCT не включён из-за размера.

---

## English

Dataset: VCT (Valorant Champions Tour) match statistics.

- **PR1 (EDA)**: loading and cleaning the data, choosing the target variable, plus a personal goal: why FNATIC lost their grand finals.
  - Analysis of matches, map drafts, map win rates, player stats, round-win methods and economy, with conclusions for each part.
- **PR2 (charts)**: Seaborn `countplot`, `barplot`, `boxplot`, `heatmap`, `pairplot`, plus a rating `histplot`, rating by map and rating by agent.
  - Every chart comes with its purpose, the commands used and conclusions.

`datasets/` holds the processed CSVs and a lesson dataset; the raw VCT archive is not included because of its size.
