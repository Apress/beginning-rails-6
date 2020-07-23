class Category < ApplicationRecord
  has_and_belongs_to_many :articles

  default_scope { order :name }
end
