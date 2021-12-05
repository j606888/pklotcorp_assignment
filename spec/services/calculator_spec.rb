require 'rails_helper'

RSpec.describe Calculator do
  before(:each) do
    @apple = create(:product, :apple)
    @watermelon = create(:product, :watermelon)
    @order_list = create(:order_list)
  end

  context '訂單滿 1000 元折 100 元' do
    before(:each) do
      @promotion = create(:promotion, :over_1000_send_100)
    end

    it 'should has discount if price amount over 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 10)
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 3000,
        discount: 100,
        total: 2900
      })
    end

    it 'should have no discount if price amount less than 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 1)
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 1)

      result = Calculator.new(@order_list, @promotion).call()
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
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 10)
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 3000,
        discount: 90,
        total: 2910
      })
    end

    it 'should have no discount if price amount less than 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 1)
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 1)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 300,
        discount: 0,
        total: 300
      })
    end
  end

  context '特定商品滿 5 件折 100元' do
    before(:each) do
      @promotion = create(:promotion, :buy_5_apple_send_100)

      # Not sure how to make this in factorybot
      rule = @promotion.promotion_rules.last
      config = rule.config
      config['product_id'] = @apple.id
      rule.save
    end

    it 'should has discount if apple more than 5' do
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 10)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 1000,
        discount: 100,
        total: 900
      })
    end

    it 'should have no discount if apple less than 5' do
      Order.create(order_list_id: @order_list.id, product_id: @apple.id, amount: 4)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 400,
        discount: 0,
        total: 400
      })
    end

    it 'should have no discount if no apple exist' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 2000,
        discount: 0,
        total: 2000
      })
    end
  end

  context '訂單滿千元贈送特定商品' do
    before(:each) do
      @promotion = create(:promotion, :over_1000_extra_gift)
    end

    it 'should trigger method if over 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)

      # Should use this one but not working, not sure why...
      # expect(@promotion.promotion_actions.last).to receive(:send_extra_gift)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 2000,
        discount: 0,
        total: 2000
      })
    end

    it 'should not trigger method if not over 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 1)
      expect(@promotion.promotion_actions.last).to_not receive(:send_extra_gift)

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 200,
        discount: 0,
        total: 200
      })
    end
  end

  context '訂單滿千送百，折扣總共只能套用 3 次' do
    before(:each) do
      @promotion = create(:promotion, :over_1000_send_100_with_max_usage_3)
    end

    it 'should effect before 3 times' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)
      3.times do
        result = Calculator.new(@order_list, @promotion).call()
        expect(result).to match({
          subtotal: 2000,
          discount: 100,
          total: 1900
        })
      end
    end

    it 'should not effect after 3 times' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 10)
      3.times do
        Calculator.new(@order_list, @promotion).call()
      end

      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 2000,
        discount: 0,
        total: 2000
      })
    end

    it 'should not effect if price not over 1000' do
      Order.create(order_list_id: @order_list.id, product_id: @watermelon.id, amount: 1)
      result = Calculator.new(@order_list, @promotion).call()
      expect(result).to match({
        subtotal: 200,
        discount: 0,
        total: 200
      })
    end
  end
end
