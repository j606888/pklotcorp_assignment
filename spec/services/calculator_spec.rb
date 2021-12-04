require 'rails_helper'

RSpec.describe Calculator do
  before(:each) do
    @apple = create(:product, :apple)
    @watermelon = create(:product, :watermelon)
  end

  context '訂單滿 1000 元折 100 元' do
    before(:each) do
      @promotion = create(:promotion, :over_1000_send_100)
    end

    it 'should has discount if price amount over 1000' do
      order_list = create(:order_list)
      Order.create(order_list_id: order_list.id, product_id: @apple.id, amount: 10)
      Order.create(order_list_id: order_list.id, product_id: @watermelon.id, amount: 10)
      expect(order_list.subtotal).to eq(3000)

      result = Calculator.new(order_list, @promotion).call()
      expect(result).to match({
        subtotal: 3000,
        discount: 100,
        total: 2900
      })
    end

    it 'should have no discount if price amount less than 1000' do
      order_list = create(:order_list)
      Order.create(order_list_id: order_list.id, product_id: @apple.id, amount: 1)
      Order.create(order_list_id: order_list.id, product_id: @watermelon.id, amount: 1)
      expect(order_list.subtotal).to eq(300)

      result = Calculator.new(order_list, @promotion).call()
      expect(result).to match({
        subtotal: 300,
        discount: 0,
        total: 300
      })
    end
  end

  context '訂單滿 1000 元折 3%' do
    before(:each) do
      @promotion = create(:promotion, :over_1000_3_percent_off)
    end

    it 'should has discount if price amount over 1000' do
      order_list = create(:order_list)
      Order.create(order_list_id: order_list.id, product_id: @apple.id, amount: 10)
      Order.create(order_list_id: order_list.id, product_id: @watermelon.id, amount: 10)
      expect(order_list.subtotal).to eq(3000)

      result = Calculator.new(order_list, @promotion).call()
      expect(result).to match({
        subtotal: 3000,
        discount: 90,
        total: 2910
      })
    end

    it 'should have no discount if price amount less than 1000' do
      order_list = create(:order_list)
      Order.create(order_list_id: order_list.id, product_id: @apple.id, amount: 1)
      Order.create(order_list_id: order_list.id, product_id: @watermelon.id, amount: 1)
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
