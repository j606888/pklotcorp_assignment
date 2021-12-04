class Calculator
    def initialize(order_list, promotion)
        @order_list = order_list
        @promotion = promotion
    end

    def call
        raise "order_list not found" if @order_list.nil?
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