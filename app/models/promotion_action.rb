class PromotionAction < ApplicationRecord
  validate :config_must_be_valid

  belongs_to :promotion

  VALID_ACTIONS = ["fixed_discount", "percentage_discount", "extra_gift"]

  ACTION_CONFIG = {
    fixed_discount: ['amount'],
    percentage_discount: ['percentage'],
    extra_gift: ['product_id']
  }

  def trigger(subtotal)
    case self.action_type
    when 'fixed_discount'
      self.config['amount']
    when 'percentage_discount'
      self.config['percentage'] * 0.01 * subtotal
    else
      0
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
end
