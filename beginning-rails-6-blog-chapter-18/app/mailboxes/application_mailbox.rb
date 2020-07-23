class ApplicationMailbox < ActionMailbox::Base
  routing /@drafts\./i => :draft_articles
end
