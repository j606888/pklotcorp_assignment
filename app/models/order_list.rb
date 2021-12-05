class OrderList < ApplicationRecord
  belongs_to :user
  has_many :orders

  def subtotal
    orders.sum(&:subtotal)
  end

  def amount_for_product(product_id)
    orders.each do |order|
      next if order.product_id != product_id

      return order.amount
    end

    0
  end
end
