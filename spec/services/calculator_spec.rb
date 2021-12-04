require 'rails_helper'

RSpec.describe Calculator do
  context '訂單滿 1000 元折 100 元' do
    before(:each) do
      @promotion = create(:promotion_1000_send_100)
      create(:rule_over_total, promotion_id: @promotion.id)
      create(:action_fixed_discount, promotion_id: @promotion.id)
    end

    it 'should has discount if price amount over 1000' do
    end

    it 'should have no discount if price amount less than 1000' do
    end
  end
end
