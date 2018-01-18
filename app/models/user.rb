class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :username, presence: true, uniqueness: true
end
