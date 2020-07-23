require 'test_helper'

class DraftArticlesMailerTest < ActionMailer::TestCase
  test "no_author" do
    mail = DraftArticlesMailer.no_author
    assert_equal "No author", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
