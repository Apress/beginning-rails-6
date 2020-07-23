class DraftArticlesMailerPreview < ActionMailer::Preview
  def created
    DraftArticlesMailer.created('test@example.com', Article.first)
  end

  def no_author
    DraftArticlesMailer.no_author('test@example.com')
  end
end
