const STORAGE_KEY = 'melstroy_tasks';
const statuses = ['pfuuu', 'choto', 'davai', 'letsgo'];
const statusLabels = {
    'pfuuu': 'пфууууу',
    'choto': 'ну чото чото',
    'davai': 'ДАВАЙ ДАВАЙ',
    'letsgo': 'юхуууу летсгоууу'
};

let tasks = [];

function loadTasks() {
    const raw = localStorage.getItem(STORAGE_KEY);
    tasks = raw ? JSON.parse(raw) : [];
}

function saveTasks() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(tasks));
}

function showNotification(text, isError = false) {
    const notif = document.getElementById('notification');
    notif.textContent = text;
    notif.style.display = 'block';
    notif.style.background = isError ? '#3a2020' : '#22223b';
    notif.style.borderColor = isError ? '#e57373' : '#f9a825';
    setTimeout(() => { notif.style.display = 'none'; }, 3000);
}

function addTask() {
    const titleEl = document.getElementById('taskTitle');
    const title = titleEl.value.trim();
    if (!title) {
        showNotification('Введи название задачи', true);
        return;
    }
    const newTask = {
        id: Date.now().toString(),
        title: title,
        status: 'pfuuu'
    };
    tasks.push(newTask);
    saveTasks();
    titleEl.value = '';
    renderBoard();
    showNotification('Задача добавлена');
}

function moveTask(id, newStatus) {
    const task = tasks.find(t => t.id === id);
    if (task && task.status !== newStatus) {
        task.status = newStatus;
        saveTasks();
        renderBoard();
        showNotification(`Статус → ${statusLabels[newStatus]}`);
    }
}

function getFilteredTasks() {
    const filter = document.getElementById('filterInput').value.trim().toLowerCase();
    if (!filter) return tasks;
    return tasks.filter(t => t.title.toLowerCase().includes(filter));
}

function renderBoard() {
    const board = document.getElementById('board');
    board.innerHTML = '';
    const filtered = getFilteredTasks();

    statuses.forEach(status => {
        const col = document.createElement('div');
        col.className = 'column';
        col.setAttribute('data-status', status);
        const count = filtered.filter(t => t.status === status).length;
        col.innerHTML = `<h3>${statusLabels[status]} (${count})</h3>`;

        col.addEventListener('dragover', e => {
            e.preventDefault();
            col.classList.add('drag-over');
        });
        col.addEventListener('dragleave', () => {
            col.classList.remove('drag-over');
        });
        col.addEventListener('drop', e => {
            e.preventDefault();
            col.classList.remove('drag-over');
            const id = e.dataTransfer.getData('text/plain');
            moveTask(id, status);
        });

        filtered.filter(t => t.status === status).forEach(task => {
            const card = document.createElement('div');
            card.className = 'card';
            card.draggable = true;
            card.setAttribute('data-id', task.id);
            card.textContent = task.title;
            card.addEventListener('dragstart', e => {
                e.dataTransfer.setData('text/plain', task.id);
                card.classList.add('dragging');
            });
            card.addEventListener('dragend', () => {
                card.classList.remove('dragging');
            });
            col.appendChild(card);
        });

        board.appendChild(col);
    });

    document.getElementById('taskCounter').textContent = tasks.length;
}

document.getElementById('addBtn').addEventListener('click', addTask);
document.getElementById('filterInput').addEventListener('input', renderBoard);

document.addEventListener('DOMContentLoaded', () => {
    loadTasks();
    renderBoard();
});