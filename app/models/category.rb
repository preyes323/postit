class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    the_slug = to_slug name
    category = Category.find_by slug: the_slug
    count = 2
    while category && category != self
      the_slug = append_suffix the_slug, count
      category = Category.find_by slug: the_slug
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
