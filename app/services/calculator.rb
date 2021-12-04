class Calculator
    def initialize(order_list_id, promotion_id)
        @order_list_id = order_list_id
        @promotion_id = promotion_id
    end

    def call
        @order_list = OrderList.find_by(id: @order_list_id)
        raise "order not found" if @order.nil?
        @promotion = Promotion.find_by(id: @promotion_id)
        raise "promotion not found" if @promotion.nil?
        @result = {
            subtotal: @order_list.subtotal,
            discount: 0,
            total: @order_list.subtotal
        }

        if is_promotion_usable?
            calculate_discount_and_action
        end

        return @result
    end

    private
    def is_promotion_usable?
        @promotion.promotion_rules.each do |rule|
            return false unless rule.is_usable?(@order_list)
        end

        true
    end

    def calculate_discount_and_action
        discount = 0
        @promotion.promotion_actions.each do |action|
            discount += action.trigger(@order_list.subtotal)
        end

        @result[:discount] += discount
        @result[:total] -= discount
    end
end