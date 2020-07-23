class EmailAFriend
  include ActiveModel::Model

  attr_accessor :name, :email

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
