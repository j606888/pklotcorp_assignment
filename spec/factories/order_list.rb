FactoryBot.define do
    factory :order_list, class: 'OrderList' do
        association :user
    end
end