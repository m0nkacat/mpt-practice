function getAllPosts() {
  return loadFromStorage('posts') || [];
}

function saveAllPosts(posts) {
  saveToStorage('posts', posts);
}

function getPostById(postId) {
  const posts = getAllPosts();
  return posts.find(p => p.id === postId);
}

function updatePost(updatedPost) {
  const posts = getAllPosts();
  const index = posts.findIndex(p => p.id === updatedPost.id);
  if (index !== -1) {
    posts[index] = updatedPost;
    saveAllPosts(posts);
  }
}

function toggleLike(postId) {
  const posts = getAllPosts();
  let user = getCurrentUser();
  if (!user) return;

  const post = posts.find(p => p.id === postId);
  if (!post) return;

  const alreadyLiked = userLikesPost(user, postId);

  if (alreadyLiked) {
    post.likes = Math.max(0, post.likes - 1);
    user.likedPosts = user.likedPosts.filter(id => id !== postId);
    user = decreaseInterests(user, post.tags);
  } else {
    post.likes += 1;
    user.likedPosts.push(postId);
    user = updateInterests(user, post.tags);
  }

  updatePost(post);
  saveCurrentUser(user);
}

function addComment(postId, text) {
  if (!text.trim()) return;
  const posts = getAllPosts();
  let user = getCurrentUser();
  if (!user) return;

  const post = posts.find(p => p.id === postId);
  if (!post) return;

  const commentEntry = `${user.username}: ${text.trim()}`;
  post.comments.push(commentEntry);
  user = updateInterests(user, post.tags);

  updatePost(post);
  saveCurrentUser(user);
}

function getRecommendedPosts() {
  const user = getCurrentUser();
  const posts = getAllPosts();
  if (!user) return posts.slice(0, 10);

  const interests = user.interests;

  const scored = posts.map(post => {
    let score = 0;
    if (post.showToAll) score = 0.1;
    for (let tag of post.tags) {
      score += interests[tag] || 0;
    }
    return { ...post, score };
  });

  scored.sort((a, b) => b.score - a.score);
  return scored.slice(0, 10);
}