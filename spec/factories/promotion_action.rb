FactoryBot.define do
    factory :promotion_action do
        trait :fixed_discount do
            action_type { 'fixed_discount' }
            config { { amount: 100 } }
        end

        trait :percentage_discount do
            action_type { 'percentage_discount' }
            config { { percentage: 3 } }
        end

        trait :extra_gift do
            action_type { 'extra_gift' }
            config { { product_id: 999 } }
        end

        trait :percentage_discount_with_max_discount_amount do
            action_type { 'percentage_discount' }
            config { { percentage: 3, max_discount_amount: 300 } }
        end

        trait :fixed_discount_with_monthly_max_discount_amount do
            action_type { 'fixed_discount' }
            config { { amount: 100, monthly_max_discount_amount: 300 } }
        end
    end
end