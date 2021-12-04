FactoryBot.define do
    factory :product, class: 'Product' do
        trait :apple do
            name { "Apple" }
            price { 100 }
        end

        trait :watermelon do
            name { "Watermelon" }
            price { 200 }
        end
    end
end