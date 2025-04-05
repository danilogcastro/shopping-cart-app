# {
#   "id": 789, // id do carrinho
#   "products": [
#     {
#       "id": 645,
#       "name": "Nome do produto",
#       "quantity": 2,
#       "unit_price": 1.99, // valor unitário do produto
#       "total_price": 3.98, // valor total do produto
#     },
#     {
#       "id": 646,
#       "name": "Nome do produto 2",
#       "quantity": 2,
#       "unit_price": 1.99,
#       "total_price": 3.98,
#     },
#   ],
#   "total_price": 7.96 // valor total no carrinho
# }
# 

json.id cart.id

json.products cart.items do |item|
  json.name item.product.name
  json.quantity item.quantity
  json.unit_price item.product.price
  json.total_price item.quantity * item.product.price
  json.id item.product.id
end

json.total_price cart.calculate_total