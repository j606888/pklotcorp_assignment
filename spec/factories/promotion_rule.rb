FactoryBot.define do
    factory :rule_over_total, class: 'PromotionRule' do
        rule_type { 'over_total' }
        config { { amount: 1000 } }
    end
end