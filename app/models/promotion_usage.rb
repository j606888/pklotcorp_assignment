class PromotionUsage < ApplicationRecord
  belongs_to :promotion
  belongs_to :user
end
