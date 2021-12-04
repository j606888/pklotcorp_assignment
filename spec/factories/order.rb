FactoryBot.define do
    factory :order_1, class: 'Order' do
        association :order_list_1
        association :product_apple
        amount { 2 }
    end

    factory :order_2, class: 'Order' do
        association :order_list_1
        association :product_watermelon
        amount { 3 }
    end
end