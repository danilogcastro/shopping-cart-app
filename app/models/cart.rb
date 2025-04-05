class Cart < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  # CONSIDERO UM POUCO PROBLEMÁTICO TER UMA COLUNA total_price QUE É DEPENDENTE
  # DE DADOS CONTIDOS EM OUTRA TABELA, E QUE PRECISARIA SER ATUALIZADA
  # TODA VEZ QUE UM NOVO ITEM É ADICIONADO AO CARRINHO, QUALQUER ERRO
  # PODENDO LEVAR A INCONSISTÊNCIAS
  def calculate_total
    items.joins(:product).sum('quantity * products.price')
  end

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado

end
