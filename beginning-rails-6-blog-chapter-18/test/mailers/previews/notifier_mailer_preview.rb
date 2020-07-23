# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier_mailer/email_friend
  def email_friend
    NotifierMailer.email_friend(Article.first, 'Sender T. Sendington', 'ree.seever@example.com')
  end

  def comment_added
    comment = Article.first.comments.build(
      name: 'Anonymous Reader',
      email: 'guesswho@example.com',
      body: 'This article changed my life.',
    )
    NotifierMailer.comment_added(comment)
  end
end
