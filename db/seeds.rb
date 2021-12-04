# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


promotions = [
    {
        code: '1000_send_100',
        name: '訂單滿千送百',
        rules: [
            {
                rule_type: 'over_total',
                config: {
                    amount: 1000
                }
            }
        ],
        actions: [
            {
                action_type: 'fixed_discount',
                config: {
                    amount: 100
                }
            }
        ]
    },
    {
        code: '1000_send_3_percent',
        name: '訂單滿千折3%',
        rules: [
            {
                rule_type: 'over_total',
                config: {
                    amount: 1000
                }
            }
        ],
        actions: [
            {
                action_type: 'percentage_discount',
                config: {
                    percentage: 3
                }
            }
        ]
    }
]

promotions.each do |promotion_setting|
    promotion = Promotion.create(
        code: promotion_setting[:code],
        name: promotion_setting[:name]
    )

    promotion_setting[:rules].each do |rule|
        PromotionRule.create(
            promotion_id: promotion.id,
            rule_type: rule[:rule_type],
            config: rule[:config]
        )
    end

    promotion_setting[:actions].each do |action|
        PromotionAction.create(
            promotion_id: promotion.id,
            action_type: action[:action_type],
            config: action[:config]
        )
    end
end
