FactoryBot.define do
  factory :item, class: Item do
    association :cart, factory: :shopping_cart
    product
    quantity { 1 }
  end
end