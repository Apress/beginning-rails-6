import consumer from "./consumer"

consumer.subscriptions.create("ArticlesChannel", {
  received(data) {
    if (data.new_article) {
      this.displayNewArticleNotification(data.new_article);
    }
  },

  displayNewArticleNotification(newArticle) {
    const body = document.querySelector('body');
    body.insertAdjacentHTML('beforeend', newArticle);

    const newArticleNotification = document.querySelector('#new-article-notification');
    setTimeout(() => {
      body.removeChild(newArticleNotification);
    }, 3000);
  }
})
