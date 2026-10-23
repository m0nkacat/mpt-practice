function showScreen(screenId) {
  document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
  document.getElementById(screenId).classList.add('active');
}

function escapeHtml(text) {
  const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
  return text.replace(/[&<>"']/g, m => map[m]);
}

function updateBubbleIndicator(percent) {
  document.getElementById('bubble-percent').textContent = `${percent}%`;
}

function renderFeed() {
  const container = document.getElementById('feed-container');
  const recommended = getRecommendedPosts();
  const user = getCurrentUser();
  container.innerHTML = '';

  if (recommended.length === 0) {
    container.innerHTML = '<p id="empty-feed-msg">Лента пуста. Загрузите JSON или добавьте посты.</p>';
    updateBubbleIndicator(0);
    return;
  }

  let matchingCount = 0;
  const userInterests = user ? Object.keys(user.interests) : [];

  recommended.forEach(post => {
    const hasMatchingTag = post.tags.length === 0 || post.tags.some(tag => userInterests.includes(tag));
    if (hasMatchingTag) matchingCount++;

    const isLiked = userLikesPost(user, post.id);
    const postEl = document.createElement('div');
    postEl.className = 'post';
    postEl.innerHTML = `
      <div class="post-content">
        <p>${escapeHtml(post.content)}</p>
        <div class="post-tags">
          ${post.tags.map(tag => `<span class="tag">#${escapeHtml(tag)}</span>`).join(' ')}
        </div>
      </div>
      <div class="post-actions">
        <button class="like-btn ${isLiked ? 'liked' : ''}">
          ❤️ <span class="like-count">${post.likes}</span>
        </button>
        <input type="text" placeholder="Комментарий..." class="comment-input">
        <button class="comment-btn">✉️</button>
      </div>
      <div class="post-comments">
        ${post.comments.map(c => `<p>${escapeHtml(c)}</p>`).join('')}
      </div>
    `;

    const likeBtn = postEl.querySelector('.like-btn');
    const commentInput = postEl.querySelector('.comment-input');
    const commentBtn = postEl.querySelector('.comment-btn');

    likeBtn.addEventListener('click', () => {
      toggleLike(post.id);
      renderFeed();
    });

    const submitComment = () => {
      addComment(post.id, commentInput.value);
      renderFeed();
    };
    commentBtn.addEventListener('click', submitComment);
    commentInput.addEventListener('keypress', (e) => {
      if (e.key === 'Enter') submitComment();
    });

    container.appendChild(postEl);
  });

  const percent = Math.round((matchingCount / recommended.length) * 100);
  updateBubbleIndicator(percent);
}

function setupRegistration() {
  const form = document.getElementById('reg-form');
  const checkboxes = form.querySelectorAll('input[type="checkbox"]');
  const startBtn = document.getElementById('start-btn');

  function updateButtonState() {
    const checked = Array.from(checkboxes).filter(cb => cb.checked).length;
    startBtn.disabled = checked < 3;
    startBtn.textContent = checked < 3
      ? `Выберите минимум 3 темы (выбрано ${checked})`
      : 'Войти в пузырь';
  }

  checkboxes.forEach(cb => cb.addEventListener('change', updateButtonState));
  updateButtonState();

  form.addEventListener('submit', e => {
    e.preventDefault();
    const selectedTags = Array.from(checkboxes).filter(cb => cb.checked).map(cb => cb.value);
    const username = document.getElementById('username').value.trim();
    if (selectedTags.length < 3 || !username) return;

    const user = createUser(username, selectedTags);
    saveCurrentUser(user);
    showScreen('feed-screen');
    renderFeed();
  });
}

function setupJsonLoader() {
  const loadBtn = document.getElementById('load-json-btn');
  const fileInput = document.getElementById('json-file-input');

  loadBtn.addEventListener('click', () => fileInput.click());

  fileInput.addEventListener('change', (event) => {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const json = JSON.parse(e.target.result);
        if (!Array.isArray(json)) {
          alert('Ошибка: JSON должен быть массивом постов.');
          return;
        }
        const isValid = json.every(item => item.content && Array.isArray(item.tags));
        if (!isValid) {
          alert('Ошибка: неверная структура постов. Каждый пост должен содержать поля content и tags (массив).');
          return;
        }
        saveAllPosts(json);
        alert(`Загружено ${json.length} постов!`);
        renderFeed();
      } catch (err) {
        alert('Ошибка чтения JSON: ' + err.message);
      }
    };
    reader.readAsText(file);
    fileInput.value = '';
  });
}

function setupResetButton() {
  document.getElementById('reset-btn').addEventListener('click', () => {
    localStorage.removeItem('currentUser');
    showScreen('registration-screen');
  });
}

function setupNeutralButton() {
  document.getElementById('add-neutral-btn').addEventListener('click', () => {
    alert('Функция добавления нейтрального поста появится позже.');
  });
}