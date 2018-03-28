class Productgroup < ApplicationRecord
  validates :title, presence: true
  has_many :products
end
