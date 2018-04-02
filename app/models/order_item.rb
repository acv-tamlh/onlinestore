class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validate :product_present, :order_present
  before_save :finalize
  # save product price, when user shopping and admin change price, user will use old price
  def unit_price
    return self[:unit_price] if persisted?
    product.price
  end

  def total_price
    unit_price * quantity
  end
  private
    def product_present
      errors.add(:product, "is not avalable") if product.blank?
    end
    def order_present
      errors.add(:order, 'is not a valid order') if order.blank?
    end
    def finalize
      self[:unit_price] = unit_price
      self[:total_price] = quantity * self[:unit_price]
    end
end
