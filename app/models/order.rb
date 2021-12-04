class Order < ApplicationRecord
  belongs_to :product
  belongs_to :order_list

  def subtotal
    product.price * self.amount
  end
end
