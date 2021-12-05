FactoryBot.define do
    factory :promotion_rule, class: 'PromotionRule' do
        trait :over_total do
            rule_type { 'over_total' }
            config { { amount: 1000 } }
        end

        trait :special_product_over_amount do
            rule_type { 'special_product_over_amount' }
            config { { amount: 5 } }
        end

        trait :max_usage_count do
            rule_type { 'max_usage_count' }
            config { { count: 3 } }
        end
    end
end