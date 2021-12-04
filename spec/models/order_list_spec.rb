require 'rails_helper'

RSpec.describe OrderList, type: :model do
  context '#subtotal' do
    it 'should return the correct subtotal' do
      product1 = create(:product_apple)
      product2 = create(:product_watermelon)

      order_list = create(:order_list_1)

      order = Order.create(product_id: product1.id, order_list_id: order_list.id, amount: 3)
      order = Order.create(product_id: product2.id, order_list_id: order_list.id, amount: 2)

      expect(order_list.subtotal).to eq(700)
    end
  end
end
