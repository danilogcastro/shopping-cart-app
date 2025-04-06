class Cart < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  enum :status, { active: 0, abandoned: 1}

  def calculate_total
    items.joins(:product).sum('quantity * products.price')
  end

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado
  def mark_as_abandoned
    update(status: 'abandoned')
  end

  def remove_if_abandoned
    return unless abandoned? && stale?

    destroy
  end

  def stale?
    last_interaction_at < 7.days.ago
  end
end