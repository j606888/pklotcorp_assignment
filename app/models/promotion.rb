class Promotion < ApplicationRecord
    has_many :promotion_rules
    has_many :promotion_actions
    has_many :promotion_usages
end
