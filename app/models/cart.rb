class Cart < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  def calculate_total
    items.joins(:product).sum('quantity * products.price')
  end

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado

end
