FactoryBot.define do
    factory :promotion_action, class: 'PromotionAction' do
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
    end
end