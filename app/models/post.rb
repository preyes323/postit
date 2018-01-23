class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true

  before_save :generate_slug

  def total_votes
    up_vote - down_vote
  end

  def to_param
    slug
  end

  private

  def up_vote
    votes.where(vote: true).size
  end

  def down_vote
    votes.where(vote: false).size
  end

  def generate_slug
    the_slug = to_slug title
    post = Post.find_by slug: the_slug
    count = 2
    while post && post != self
      the_slug = append_suffix the_slug, count
      post = Post.find_by slug: the_slug
      count += 1
    end

    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      str + '-' + count.to_s
    end
  end

  def to_slug(title)
    title.strip!
    title.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    title.gsub!(/-+/, '-')
    title.downcase
  end
end
