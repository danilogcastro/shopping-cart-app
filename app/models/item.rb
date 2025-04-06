class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  after_commit :update_cart_total

  # CONSIDERO UM POUCO PROBLEMÁTICO TER UMA COLUNA total_price QUE É DEPENDENTE
  # DE DADOS CONTIDOS EM OUTRA TABELA, E QUE PRECISARIA SER ATUALIZADA
  # TODA VEZ QUE UM NOVO ITEM É ADICIONADO AO CARRINHO, QUALQUER ERRO
  # PODENDO LEVAR A INCONSISTÊNCIAS
  def update_cart_total
    cart.update(total_price: cart.calculate_total)
  end
end