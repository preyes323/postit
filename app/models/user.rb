class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :username, presence: true, uniqueness: true

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    the_slug = to_slug username
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      the_slug = append_suffix the_slug, count
      user = User.find_by slug: the_slug
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
