const DEFAULT_POSTS = [
  { id: 'post1', content: 'Искусственный интеллект помогает врачам ставить диагнозы #технологии #наука', tags: ['технологии', 'наука'], likes: 5, comments: [], showToAll: false },
  { id: 'post2', content: 'Новый способ очистки океана от пластика #экология #технологии', tags: ['экология', 'технологии'], likes: 8, comments: [], showToAll: false },
  { id: 'post3', content: 'Почему спортсмены переходят на веганское питание? #спорт #еда', tags: ['спорт', 'еда'], likes: 3, comments: [], showToAll: false },
  { id: 'post_neutral1', content: 'Что думаете о последних событиях? (пост без тегов)', tags: [], likes: 0, comments: [], showToAll: true }
]; // Начальный набор постов для первого запуска

const AVAILABLE_TAGS = ['технологии', 'экология', 'спорт', 'политика', 'игры', 'музыка', 'кино', 'наука', 'еда', 'путешествия']; // Список всех доступных тегов

function storageAvailable() { // Проверяет, доступен ли localStorage
  try { const t = '__t__'; localStorage.setItem(t, t); localStorage.removeItem(t); return true; } catch (e) { return false; }
}

function loadFromStorage(key) { // Загружает данные из localStorage по ключу
  if (!storageAvailable()) return null;
  const d = localStorage.getItem(key); return d ? JSON.parse(d) : null;
}

function saveToStorage(key, data) { // Сохраняет данные в localStorage
  if (!storageAvailable()) return false;
  try { localStorage.setItem(key, JSON.stringify(data)); return true; } catch (e) { return false; }
}

function initStorage() { // Инициализирует хранилище начальными данными
  if (!storageAvailable()) { alert('localStorage недоступен.'); return; }
  if (!loadFromStorage('posts')) saveToStorage('posts', DEFAULT_POSTS);
  if (!loadFromStorage('tags')) saveToStorage('tags', AVAILABLE_TAGS);
  if (!loadFromStorage('users')) saveToStorage('users', []);
}

function getUsers() { return loadFromStorage('users') || []; } // Получить всех пользователей
function saveUsers(users) { saveToStorage('users', users); } // Сохранить массив пользователей

function findUser(username) { // Найти пользователя по логину
  return getUsers().find(u => u.username === username);
}

function addUser(user) { // Добавить нового пользователя
  const users = getUsers();
  users.push(user);
  saveUsers(users);
}

function updateUser(updatedUser) { // Обновить данные существующего пользователя
  const users = getUsers();
  const idx = users.findIndex(u => u.username === updatedUser.username);
  if (idx !== -1) {
    users[idx] = updatedUser;
    saveUsers(users);
  }
}

function getCurrentUser() { // Получить текущего авторизованного пользователя
  const username = loadFromStorage('currentUser');
  if (!username) return null;
  return findUser(username) || null;
}

function login(username, password) { // Попытка входа
  const user = findUser(username);
  if (!user || user.password !== password) return false;
  saveToStorage('currentUser', username);
  return true;
}

function logout() { // Выход из системы
  localStorage.removeItem('currentUser');
}

function register(username, password, selectedTags) { // Регистрация нового пользователя
  if (findUser(username)) return false; // Пользователь уже существует
  const interests = {};
  selectedTags.forEach(t => interests[t] = 1); // Начальный вес 1 для выбранных тегов
  const newUser = {
    username,
    password,
    interests,
    likedPosts: [],
    comments: []
  };
  addUser(newUser);
  saveToStorage('currentUser', username); // Сразу логиним
  return true;
}

function updateInterests(user, tags) { // Увеличить вес тегов на 1
  if (!user || !tags.length) return user;
  const i = { ...user.interests };
  tags.forEach(t => i[t] = (i[t] || 0) + 1);
  return { ...user, interests: i };
}

function decreaseInterests(user, tags) { // Уменьшить вес тегов на 1 (не ниже 0)
  if (!user || !tags.length) return user;
  const i = { ...user.interests };
  tags.forEach(t => { if (i[t] && i[t] > 0) i[t] -= 1; });
  return { ...user, interests: i };
}

function userLikesPost(user, pid) { return user && user.likedPosts.includes(pid); } // Проверить, лайкал ли пользователь пост

function getAllPosts() { return loadFromStorage('posts') || []; } // Все посты
function saveAllPosts(p) { saveToStorage('posts', p); } // Сохранить посты

function updatePost(up) { // Обновить конкретный пост
  const posts = getAllPosts();
  const idx = posts.findIndex(p => p.id === up.id);
  if (idx !== -1) { posts[idx] = up; saveAllPosts(posts); }
}

function assignTagsFromInterests(user) { // Получить два самых сильных тега пользователя
  if (!user || !user.interests) return [];
  const entries = Object.entries(user.interests);
  entries.sort((a, b) => b[1] - a[1]); // Сортировка по убыванию веса
  return entries.slice(0, 2).map(e => e[0]); // Первые два тега
}

function toggleLike(pid) { // Переключение лайка поста
  const posts = getAllPosts();
  let user = getCurrentUser(); if (!user) return;
  const post = posts.find(p => p.id === pid); if (!post) return;
  
  if (post.tags.length === 0 && post.showToAll) { // Если нейтральный пост
    post.tags = assignTagsFromInterests(user); // Присвоить теги на основе интересов
    post.showToAll = false; // Убрать флаг "для всех"
  }
  
  const liked = userLikesPost(user, pid);
  if (liked) { // Убрать лайк
    post.likes = Math.max(0, post.likes - 1);
    user.likedPosts = user.likedPosts.filter(id => id !== pid);
    user = decreaseInterests(user, post.tags);
  } else { // Поставить лайк
    post.likes += 1;
    user.likedPosts.push(pid);
    user = updateInterests(user, post.tags);
  }
  updatePost(post);
  updateUser(user);
}

function addComment(pid, text) { // Добавить комментарий
  if (!text.trim()) return;
  const posts = getAllPosts(); let user = getCurrentUser(); if (!user) return;
  const post = posts.find(p => p.id === pid); if (!post) return;
  
  if (post.tags.length === 0 && post.showToAll) { // Нейтральный пост
    post.tags = assignTagsFromInterests(user);
    post.showToAll = false;
  }
  
  post.comments.push(`${user.username}: ${text.trim()}`);
  user = updateInterests(user, post.tags);
  updatePost(post);
  updateUser(user);
}

function addNeutralPost() { // Добавить нейтральный пост
  const posts = getAllPosts();
  const newId = 'neutral_' + Date.now();
  posts.push({
    id: newId,
    content: 'Нейтральный пост без тегов. О чём поговорим?',
    tags: [],
    likes: 0,
    comments: [],
    showToAll: true
  });
  saveAllPosts(posts);
}

let burstMode = false; // Флаг разрыва пузыря (показывать всё)

function getRecommendedPostsForUser(user) { // Рекомендации для конкретного пользователя
  if (!user) return [];
  const posts = getAllPosts();
  if (burstMode) return [...posts]; // Показать все посты
  const interests = user.interests;
  const scored = posts.map(p => { // Считаем score для каждого поста
    let score = p.showToAll ? 0.1 : 0; // Нейтральные посты получают минимальный score
    p.tags.forEach(t => score += (interests[t] || 0)); // Добавляем вес каждого тега
    return { ...p, score };
  });
  scored.sort((a, b) => b.score - a.score); // Сортировка по убыванию score
  return scored.slice(0, 10); // Топ-10
}

function getRecommendedPosts() { // Рекомендации для текущего пользователя
  const user = getCurrentUser();
  return getRecommendedPostsForUser(user);
}

function showScreen(id) { // Показать экран по id
  document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
  document.getElementById(id).classList.add('active');
}

function escapeHtml(t) { // Экранирование HTML
  return t.replace(/[&<>"']/g, m => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]));
}

function updateBubbleIndicator(percent, hiddenCount, totalCount) { // Обновить индикатор пузыря
  const bar = document.getElementById('bubble-bar');
  const percentEl = document.getElementById('bubble-percent');
  const hiddenEl = document.getElementById('bubble-hidden-count');
  
  percentEl.textContent = `${percent}%`; // Установить процент
  bar.style.width = percent + '%';
  
  // Цвет полоски в зависимости от процента
  if (percent < 30) bar.style.background = '#17bf63';       // Зелёный
  else if (percent < 70) bar.style.background = '#ffcc00';  // Жёлтый
  else bar.style.background = '#e0245e';                    // Красный
  
  if (hiddenCount > 0) {
    hiddenEl.textContent = `(скрыто ${hiddenCount} из ${totalCount})`;
  } else {
    hiddenEl.textContent = '';
  }
}

function renderFeed() { // Отрисовка ленты
  const container = document.getElementById('feed-container');
  const allPosts = getAllPosts();
  const recommended = getRecommendedPosts();
  const user = getCurrentUser();
  container.innerHTML = '';

  if (!recommended.length) {
    container.innerHTML = '<p id="empty-feed-msg">Лента пуста. Загрузите JSON или добавьте посты.</p>';
    updateBubbleIndicator(0, 0, 0);
    return;
  }

  let matchCount = 0;
  const uInterests = user ? Object.keys(user.interests) : [];
  
  recommended.forEach(post => { // Для каждого поста в рекомендации
    const hasMatch = post.tags.length === 0 || post.tags.some(t => uInterests.includes(t));
    if (hasMatch) matchCount++;
    
    const liked = userLikesPost(user, post.id);
    const el = document.createElement('div');
    el.className = 'post';
    el.innerHTML = `
      <div class="post-content">
        <p>${escapeHtml(post.content)}</p>
        <div class="post-tags">${post.tags.map(t => `<span class="tag">#${escapeHtml(t)}</span>`).join(' ')}</div>
      </div>
      <div class="post-actions">
        <button class="like-btn ${liked?'liked':''}">❤️ <span class="like-count">${post.likes}</span></button>
        <input type="text" placeholder="Комментарий..." class="comment-input">
        <button class="comment-btn">✉️</button>
      </div>
      <div class="post-comments">${post.comments.map(c => `<p>${escapeHtml(c)}</p>`).join('')}</div>
    `;
    el.querySelector('.like-btn').onclick = () => { toggleLike(post.id); renderFeed(); }; // Обработчик лайка
    const inp = el.querySelector('.comment-input');
    const btn = el.querySelector('.comment-btn');
    const submit = () => { addComment(post.id, inp.value); renderFeed(); }; // Обработчик комментария
    btn.onclick = submit;
    inp.onkeypress = e => { if (e.key === 'Enter') submit(); }; // Отправка по Enter
    container.appendChild(el);
  });

  const totalAll = allPosts.length;
  const hiddenCount = totalAll - recommended.length;
  const percent = recommended.length > 0 ? Math.round((matchCount / recommended.length) * 100) : 0;
  updateBubbleIndicator(percent, hiddenCount, totalAll);
  
  const burstBtn = document.getElementById('burst-btn');
  if (burstMode) { // Обновление кнопки разрыва пузыря
    burstBtn.textContent = 'Вернуть пузырь';
    burstBtn.classList.add('active');
  } else {
    burstBtn.textContent = 'Разорвать пузырь';
    burstBtn.classList.remove('active');
  }
}

function openCompareModal() { // Открыть модальное окно сравнения
  const currentUser = getCurrentUser();
  if (!currentUser) return;
  document.getElementById('current-user-name').textContent = currentUser.username;
  
  const select = document.getElementById('compare-user-select');
  select.innerHTML = '';
  const users = getUsers().filter(u => u.username !== currentUser.username);
  if (users.length === 0) {
    select.innerHTML = '<option>Нет других пользователей</option>';
    document.getElementById('run-compare-btn').disabled = true;
  } else {
    users.forEach(u => {
      const opt = document.createElement('option');
      opt.value = u.username;
      opt.textContent = u.username;
      select.appendChild(opt);
    });
    document.getElementById('run-compare-btn').disabled = false;
  }
  
  document.getElementById('compare-results').style.display = 'none'; // Скрыть предыдущие результаты
  document.getElementById('compare-modal').classList.add('active'); // Показать модалку
}

function closeCompareModal() { // Закрыть модальное окно сравнения
  document.getElementById('compare-modal').classList.remove('active');
}

function performCompare() { // Выполнить сравнение
  const select = document.getElementById('compare-user-select');
  const otherUsername = select.value;
  if (!otherUsername) return;
  const user1 = getCurrentUser();
  const user2 = findUser(otherUsername);
  if (!user1 || !user2) return;

  // Таблица интересов
  const allTags = Array.from(new Set([...Object.keys(user1.interests), ...Object.keys(user2.interests)]));
  const tbody = document.querySelector('#compare-interests-table tbody');
  tbody.innerHTML = '';
  allTags.forEach(tag => {
    const row = tbody.insertRow();
    row.insertCell().textContent = tag;
    row.insertCell().textContent = user1.interests[tag] || 0;
    row.insertCell().textContent = user2.interests[tag] || 0;
  });
  document.getElementById('user1-col').textContent = user1.username;
  document.getElementById('user2-col').textContent = user2.username;

  // Пересечение интересов (коэффициент Жаккара)
  const tags1 = Object.keys(user1.interests).filter(t => user1.interests[t] > 0);
  const tags2 = Object.keys(user2.interests).filter(t => user2.interests[t] > 0);
  const intersection = tags1.filter(t => tags2.includes(t));
  const union = Array.from(new Set([...tags1, ...tags2]));
  const jaccard = union.length ? Math.round((intersection.length / union.length) * 100) : 0;
  document.getElementById('interests-overlap').textContent = 
    `Пересечение интересов (по используемым тегам): ${jaccard}%`;

  // Сравнение лент (топ-10)
  const feed1 = getRecommendedPostsForUser(user1).map(p => p.id);
  const feed2 = getRecommendedPostsForUser(user2).map(p => p.id);
  const commonPosts = feed1.filter(id => feed2.includes(id));
  const unique1 = feed1.filter(id => !feed2.includes(id));
  const unique2 = feed2.filter(id => !feed1.includes(id));
  
  document.getElementById('feeds-overlap').textContent = 
    `Общих постов в топ-10: ${commonPosts.length}. Уникальных: у ${user1.username} – ${unique1.length}, у ${user2.username} – ${unique2.length}.`;

  document.getElementById('compare-results').style.display = 'block'; // Показать результаты
}

function setupLogin() { // Обработчики для экрана входа
  document.getElementById('login-form').addEventListener('submit', e => {
    e.preventDefault();
    const username = document.getElementById('login-username').value.trim();
    const password = document.getElementById('login-password').value;
    if (login(username, password)) {
      showScreen('feed-screen');
      renderFeed();
      document.getElementById('login-form').reset();
    } else {
      alert('Неверный логин или пароль');
    }
  });
  document.getElementById('go-register-btn').addEventListener('click', () => {
    showScreen('registration-screen');
    document.getElementById('login-form').reset();
  });
}

function setupRegistration() { // Обработчики для экрана регистрации
  const form = document.getElementById('reg-form');
  const cbs = form.querySelectorAll('input[type="checkbox"]');
  const btn = document.getElementById('start-btn');
  function upd() { // Обновление состояния кнопки
    const n = Array.from(cbs).filter(c => c.checked).length;
    btn.disabled = n < 3;
    btn.textContent = n < 3 ? `Выберите минимум 3 темы (выбрано ${n})` : 'Создать и войти';
  }
  cbs.forEach(c => c.onchange = upd);
  upd();
  form.addEventListener('submit', e => {
    e.preventDefault();
    const username = document.getElementById('reg-username').value.trim();
    const password = document.getElementById('reg-password').value;
    const tags = Array.from(cbs).filter(c => c.checked).map(c => c.value);
    if (!username || !password || tags.length < 3) return;
    if (register(username, password, tags)) {
      showScreen('feed-screen');
      renderFeed();
      form.reset();
    } else {
      alert('Пользователь уже существует');
    }
  });
  document.getElementById('go-login-btn').addEventListener('click', () => {
    showScreen('login-screen');
    form.reset();
  });
}

function setupJsonLoader() { // Обработчик загрузки JSON
  const btn = document.getElementById('load-json-btn');
  const inp = document.getElementById('json-file-input');
  btn.addEventListener('click', () => inp.click());
  inp.addEventListener('change', e => {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = ev => {
      try {
        const json = JSON.parse(ev.target.result);
        if (!Array.isArray(json)) { alert('JSON должен быть массивом'); return; }
        if (!json.every(it => it.content && Array.isArray(it.tags))) { alert('Неверная структура'); return; }
        saveAllPosts(json);
        alert(`Загружено ${json.length} постов`);
        renderFeed();
      } catch (err) { alert('Ошибка JSON: ' + err.message); }
    };
    reader.readAsText(file);
    inp.value = ''; // Очищаем input для возможности повторной загрузки
  });
}

function setupLogoutButton() { // Обработчик выхода
  document.getElementById('logout-btn').addEventListener('click', () => {
    logout();
    burstMode = false;
    showScreen('login-screen');
  });
}

function setupNeutralButton() { // Обработчик кнопки нейтрального поста
  document.getElementById('add-neutral-btn').addEventListener('click', () => {
    addNeutralPost();
    renderFeed();
  });
}

function setupBurstButton() { // Обработчик кнопки разрыва пузыря
  document.getElementById('burst-btn').addEventListener('click', () => {
    burstMode = !burstMode;
    renderFeed();
  });
}

function setupCompareButton() { // Обработчики для сравнения пользователей
  document.getElementById('compare-btn').addEventListener('click', openCompareModal);
  document.querySelector('.close-modal').addEventListener('click', closeCompareModal);
  document.getElementById('run-compare-btn').addEventListener('click', performCompare);
  window.addEventListener('click', (e) => { // Закрытие по клику на оверлей
    if (e.target === document.getElementById('compare-modal')) closeCompareModal();
  });
}

document.addEventListener('DOMContentLoaded', () => {
  initStorage(); // Инициализация хранилища
  
  const currentUser = getCurrentUser();
  if (currentUser) { // Если уже вошли
    showScreen('feed-screen');
    renderFeed();
  } else { // Иначе показываем экран входа
    showScreen('login-screen');
  }
  
  // Настройка обработчиков событий
  setupLogin();
  setupRegistration();
  setupJsonLoader();
  setupLogoutButton();
  setupNeutralButton();
  setupBurstButton();
  setupCompareButton();
});