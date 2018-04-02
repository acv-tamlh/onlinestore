class Productgroup < ApplicationRecord
  validates :title, presence: true
  has_many :products

  paginates_per 5
end
