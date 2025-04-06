FactoryBot.define do
  factory :product, class: Product do
    price { 10 }
    name { "Test Product" }
  end
end