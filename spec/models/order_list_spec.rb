require 'rails_helper'

RSpec.describe OrderList, type: :model do
  context '#subtotal' do
    it 'should return the correct subtotal' do
      user = User.create
      product1 = Product.create(name: 'Apple', price: 50)
      product2 = Product.create(name: 'Watermelon', price: 100)

      order_list = OrderList.create(user_id: user.id)
      order = Order.create(product_id: product1.id, order_list_id: order_list.id, amount: 3)
      order = Order.create(product_id: product2.id, order_list_id: order_list.id, amount: 2)

      expect(order_list.subtotal).to eq(350)
    end
  end
end
