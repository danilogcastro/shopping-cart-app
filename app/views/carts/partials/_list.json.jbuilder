json.id cart.id

json.products cart.items do |item|
  json.id item.product.id
  json.name item.product.name
  json.quantity item.quantity
  json.unit_price item.product.price
  json.total_price item.quantity * item.product.price
end

json.total_price cart.calculate_total