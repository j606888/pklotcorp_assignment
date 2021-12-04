FactoryBot.define do
    factory :action_fixed_discount, class: 'PromotionAction' do
        action_type { 'fixed_discount' }
        config { { amount: 100 } }
    end
end