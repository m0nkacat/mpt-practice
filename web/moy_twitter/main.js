document.addEventListener('DOMContentLoaded', () => {
  initStorage();

  const currentUser = getCurrentUser();
  if (currentUser) {
    showScreen('feed-screen');
    renderFeed();
  } else {
    showScreen('registration-screen');
  }

  setupRegistration();
  setupJsonLoader();
  setupResetButton();
  setupNeutralButton();
});