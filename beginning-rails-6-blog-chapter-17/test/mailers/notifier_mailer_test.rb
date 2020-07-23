require 'test_helper'

class NotifierMailerTest < ActionMailer::TestCase
  def setup
    @article = articles(:welcome_to_rails)
    @sender_name = 'Reed'
    @receiver_email = 'to@example.com'
  end

  test "email_friend" do
    mail = NotifierMailer.email_friend(@article, @sender_name, @receiver_email)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal "Interesting Article", mail.subject
    assert_equal ["to@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Your friend, <em>#{@sender_name}</em>", mail.body.encoded
    assert_match @article.title, mail.body.encoded
  end
end
