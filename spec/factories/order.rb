FactoryBot.define do
    factory :order_1, class: 'Order' do
        amount { 2 }
    end

    factory :order_2, class: 'Order' do
        amount { 3 }
    end
end