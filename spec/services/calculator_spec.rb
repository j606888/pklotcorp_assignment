require 'rails_helper'

RSpec.describe Calculator do
  before(:each) do
    @product_apple = create(:product_apple)
    @product_watermelon = create(:product_watermelon)

    @promotion = create(:promotion_1000_send_100)
    create(:rule_over_total, promotion_id: @promotion.id)
    create(:action_fixed_discount, promotion_id: @promotion.id)
  end

  context '訂單滿 1000 元折 100 元' do
    it 'should has discount if price amount over 1000' do
      order_list = create(:order_list_1)
      Order.create(order_list_id: order_list.id, product_id: @product_apple.id, amount: 10)
      Order.create(order_list_id: order_list.id, product_id: @product_watermelon.id, amount: 10)
      expect(order_list.subtotal).to eq(3000)

      result = Calculator.new(order_list, @promotion).call()
      expect(result).to match({
        subtotal: 3000,
        discount: 100,
        total: 2900
      })
    end

    it 'should have no discount if price amount less than 1000' do
      order_list = create(:order_list_1)
      Order.create(order_list_id: order_list.id, product_id: @product_apple.id, amount: 1)
      Order.create(order_list_id: order_list.id, product_id: @product_watermelon.id, amount: 1)
      expect(order_list.subtotal).to eq(300)

      result = Calculator.new(order_list, @promotion).call()
      expect(result).to match({
        subtotal: 300,
        discount: 0,
        total: 300
      })
    end
  end
end
