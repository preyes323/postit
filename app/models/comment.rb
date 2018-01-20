class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true

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
