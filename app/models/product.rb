class Product < ApplicationRecord
  validates :asin, :title, presence: true
  belongs_to :Productgroup, optional: true
end
