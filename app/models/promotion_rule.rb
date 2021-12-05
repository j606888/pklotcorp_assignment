class PromotionRule < ApplicationRecord
  validate :config_must_be_valid

  belongs_to :promotion

  VALID_TYPE = ["over_total", "special_product_over_amount", "max_usage_count", "max_discount_amount", "monthly_usage_count"]

  RULE_CONFIG = {
    over_total: ['amount'],
    special_product_over_amount: ['product_id', 'amount'],
    max_usage_count: ['count'],
    max_discount_amount: ['amount'],
    monthly_usage_count: ['count']
  }

  def is_usable?(order_list)
    case rule_type
    when 'over_total'
      return order_list.subtotal > self.config['amount']
    when 'special_product_over_amount'
      product_id = self.config['product_id']
  
      product = Product.find_by(id: product_id)
      product_count = order_list.amount_for_product(product_id)
      return product_count >= config['amount']
    when 'max_usage_count'
      usage = self.promotion.promotion_usages.count
      return usage < self.config['count'] 
    end
  end

  private
  def config_must_be_valid
    required_columns = RULE_CONFIG[self.rule_type.to_sym]
    if required_columns.nil?
      errors.add(:rule_type, "Type invalid")
    end

    required_columns.each do |column|
      if self.config.keys.exclude?(column)
        errors.add(:config, "Didn't have required column setup")
      end
    end
  end
end
