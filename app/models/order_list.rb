class OrderList < ApplicationRecord
  belongs_to :user
  has_many :orders

  def subtotal
    orders.map(&:subtotal).sum
  end
end
