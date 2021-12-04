FactoryBot.define do
    factory :product_apple, class: 'Product' do
        name { "Apple" }
        price { 100 }
    end

    factory :product_watermelon, class: 'Product' do
        name { "Watermelon" }
        price { 200 }
    end
end