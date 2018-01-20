class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :user_id, scope: %i[voteable_id voteable_type]
end
