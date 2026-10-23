# Web

HTML, CSS и чистый JavaScript · *HTML, CSS and vanilla JavaScript*

### pr1js: доска статусов задач
- Канбан-доска с 4 колонками-статусами
- Добавление задачи, перетаскивание карточек между колонками (HTML5 drag-and-drop), фильтрация
- Всплывающие уведомления
- Задачи сохраняются в `localStorage`
- Файлы: `index.html`, `script.js`, `style.css`

### moy_twitter: «Информационный пузырь»
- Лента постов с тегами, лайками и комментариями
- Регистрация с выбором интересов и вход. Пользователи и посты хранятся в `localStorage`
- Рекомендации: лайк повышает вес тегов поста в интересах пользователя, снятие лайка понижает. Лента строится по самым сильным тегам
- Индикатор «пузыря» показывает, какая доля постов скрыта от пользователя
- Кнопка «нейтральный пост» и окно сравнения с другим пользователем: таблица интересов и пересечение лент
- Загрузка постов из JSON
- Файлы: `index.html`, `app.js`, `feed.js`, `ui.js`, `main.js`, `style.css`

**Запуск:** открыть `index.html` в браузере.

---

## English

- **pr1js**: kanban task board with 4 status columns, HTML5 drag-and-drop, filtering, notifications and `localStorage` persistence.
- **moy_twitter** ("filter bubble"): a feed of tagged posts with likes and comments.
  - Sign-up with interests.
  - Likes raise or lower tag weights, and the feed is built from the strongest tags.
  - A bubble indicator shows the share of hidden posts.
  - "Neutral post" button, comparison with another user (interests table and feed overlap), JSON import.

**Run:** open `index.html` in a browser.
