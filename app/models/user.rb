class User < ApplicationRecord
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :username, presence: true, uniqueness: true

  sluggable_column :username
end
