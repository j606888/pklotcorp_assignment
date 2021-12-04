FactoryBot.define do
    factory :order_list_1, class: 'OrderList' do
        association :user
    end
end