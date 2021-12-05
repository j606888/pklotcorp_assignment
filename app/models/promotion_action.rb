class PromotionAction < ApplicationRecord
  validate :config_must_be_valid

  belongs_to :promotion

  ACTION_CONFIG = {
    fixed_discount: ['amount'],
    percentage_discount: ['percentage'],
    extra_gift: ['product_id'],
    percentage_with_max_discount_amount: ['percentage', 'max_amount'],
    fixed_discount_with_monthly_usage_amount: ['amount', 'max_amount']
  }

  def trigger(subtotal)
    case self.action_type
    when 'fixed_discount'
      self.config['amount']
    when 'percentage_discount'
      self.config['percentage'] * 0.01 * subtotal
    when 'extra_gift'
      send_extra_gift
      0
    when 'percentage_with_max_discount_amount'
      discount = self.config['percentage'] * 0.01 * subtotal
      discount >= self.config['max_amount'] ? self.config['max_amount'] : discount
    when 'fixed_discount_with_monthly_usage_amount'
      this_month_range = (Date.today.beginning_of_month)..(Date.today.end_of_month)
      monthly_usage = self.promotion.promotion_usages.where(created_at: this_month_range).sum(&:discount)
      avaliable_usage = self.config['max_amount'] - monthly_usage

      self.config['amount'] > avaliable_usage ? avaliable_usage : self.config['amount']
    end
  end

  private
  def config_must_be_valid
      required_columns = ACTION_CONFIG[self.action_type.to_sym]
      if required_columns.nil?
        errors.add(:action_type, "Type invalid")
      end

      required_columns.each do |column|
        if self.config.keys.exclude?(column)
          errors.add(:config, "Didn't have required column setup")
        end
      end
  end

  def send_extra_gift
    # Extra logic can be put here in the future
    # Currenly don't check if product_id exist
  end
  
end
