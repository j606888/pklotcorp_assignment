class User < ApplicationRecord
    has_many :order_lists
    has_many :promotion_usages
end
