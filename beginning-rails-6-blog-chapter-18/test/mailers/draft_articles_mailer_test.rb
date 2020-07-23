require 'test_helper'

class DraftArticlesMailerTest < ActionMailer::TestCase
  test "no_author" do
    mail = DraftArticlesMailer.no_author('to@example.org')
    assert_equal "Your email could not be processed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Please check your draft articles email address and try again.", mail.body.encoded
  end

end
