require 'rails_helper'

RSpec.describe OrderList, type: :model do
  context '#subtotal' do
    it 'should return the correct subtotal' do
      apple = create(:product, :apple)
      watermelon = create(:product, :watermelon)

      order_list = create(:order_list)

      order = Order.create(product_id: apple.id, order_list_id: order_list.id, amount: 3)
      order = Order.create(product_id: watermelon.id, order_list_id: order_list.id, amount: 2)

      expect(order_list.subtotal).to eq(700)
    end
  end
end
