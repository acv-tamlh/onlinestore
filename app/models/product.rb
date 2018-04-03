class Product < ApplicationRecord
  validates :asin, :title, presence: true
  belongs_to :productgroup, optional: true

  default_scope { order(created_at: :DESC) }
  paginates_per 10

end
