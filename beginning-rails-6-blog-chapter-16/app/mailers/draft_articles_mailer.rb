class DraftArticlesMailer < ApplicationMailer
  def created(to, article)
    @article = article

    mail to: to, subject: 'Your Draft Article has been created.'
  end

  def no_author(to)
    mail to: to, subject: 'Your email could not be processed' do |format|
      content = 'Please check your draft articles email address and try again.'
      format.html { render plain: content }
      format.text { render plain: content }
    end
  end
end
