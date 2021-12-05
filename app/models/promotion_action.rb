class PromotionAction < ApplicationRecord
  validate :config_must_be_valid

  belongs_to :promotion

  REQUIRED_CONFIGS = {
    fixed_discount: ['amount'],
    percentage_discount: ['percentage'],
    extra_gift: ['product_id'],
  }
  OPTIONAL_CONFIG = ['max_discount_amount', 'monthly_max_discount_amount']

  def trigger(subtotal)
    discount = case self.action_type
    when 'fixed_discount'
      self.config['amount']
    when 'percentage_discount'
      self.config['percentage'] * 0.01 * subtotal
    when 'extra_gift'
      send_extra_gift
      0
    end

    if self.config['max_discount_amount'].present?
      discount = self.config['max_discount_amount'] if discount > self.config['max_discount_amount']
    end

    if self.config['monthly_max_discount_amount'].present?
        avaliable_usage = self.config['monthly_max_discount_amount'] - monthly_usage
        discount = avaliable_usage if discount > avaliable_usage
    end

    discount
  end

  def monthly_usage
    time_range = (Date.today.beginning_of_month)..(Date.today.end_of_month)
    monthly_usage = self.promotion.promotion_usages.where(created_at: time_range).sum(&:discount)
  end

  private
  def config_must_be_valid
      required_columns = REQUIRED_CONFIGS[self.action_type.to_sym]
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
