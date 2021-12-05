FactoryBot.define do
    factory :promotion do
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

        trait :over_1000_extra_gift do
            code { 'over_1000_extra_gift' }
            name { '滿千送輪胎' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :extra_gift)
            end
        end

        trait :over_1000_send_100_with_max_usage_3 do
            code { 'over_1000_send_100_with_max_usage_3' }
            name { '滿千送百，折扣只能套用三次' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :max_usage_count)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :fixed_discount)
            end
        end

        trait :over_1000_3_percent_off_with_max_300 do
            code { 'over_1000_3_percent_off_with_max_300' }
            name { '滿千折3％，折扣只能總共優惠300元' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :percentage_discount_with_max_discount_amount)
            end
        end

        trait :over_1000_send_100_with_monthly_max_300 do
            code { 'over_1000_send_100_with_monthly_max_300' }
            name { '滿千送百，每個月折扣上限為300元' }

            after(:create) do |promotion|
                promotion.promotion_rules << FactoryBot.build(:promotion_rule, :over_total)
                promotion.promotion_actions << FactoryBot.build(:promotion_action, :fixed_discount_with_monthly_max_discount_amount)
            end
        end
    end
end