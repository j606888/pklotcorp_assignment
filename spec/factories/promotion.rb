FactoryBot.define do
    factory :promotion, class: 'Promotion' do
        trait :over_1000_send_100 do
            code { 'over_1000_send_100' }
            name { '滿千送百' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :fixed_discount)
            end
        end

        trait :over_1000_3_percent_off do
            code { 'over_1000_3_percent_off' }
            name { '滿千折3%' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :percentage_discount)
            end
        end

        trait :buy_5_apple_send_100 do
            code { 'buy_5_apple_send_100' }
            name { '蘋果買五折100' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :special_product_over_amount)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :fixed_discount)
            end
        end
    end
end