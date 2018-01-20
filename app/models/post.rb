class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true

  def total_votes
    up_vote - down_vote
  end

  private

  def up_vote
    votes.where(vote: true).size
  end

  def down_vote
    votes.where(vote: false).size
  end
end
