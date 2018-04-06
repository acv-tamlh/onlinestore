class Product < ApplicationRecord
  validates :asin, :title, presence: true

  belongs_to :productgroup, optional: true
  has_many :order_items

  default_scope { order(created_at: :DESC) }
  paginates_per 20

end
