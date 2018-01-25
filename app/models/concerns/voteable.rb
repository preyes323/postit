module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

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
