class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validate :product_present, :order_present
  before_save :finalize
  # save product price, when user shopping and admin change price, user will use old price
  def unit_price
    # byebug
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end
  def total_price
    unit_price * quantity
  end
  private
    def product_present
      if product.nil?
        errors.add(:product, "is not avalable")
      end
    end
    def order_present
      if order.nil?
        errors.add(:order, 'is not a valid order')
      end
    end
    def finalize
      self[:unit_price] = unit_price
      self[:total_price] = quantity * self[:unit_price]
    end
end
