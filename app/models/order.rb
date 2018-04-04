class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user, optional: true
  before_create :set_order_status
  before_save :update_subtotal

  default_scope { order(created_at: :DESC) }
  paginates_per 5

  extend Enumerize
    enumerize :order_status, in: ['In Process', 'Paid', 'Waiting']

  def subtotal
    order_items.collect{ |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum

  end
  private
    def set_order_status
      self.order_status = 'In Process'
    end

    def update_subtotal
      self[:subtotal] = subtotal
    end
end
