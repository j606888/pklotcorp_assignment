FactoryBot.define do
    factory :promotion_rule, class: 'PromotionRule' do
        trait :over_total do
            rule_type { 'over_total' }
            config { { amount: 1000 } }
        end
    end
end