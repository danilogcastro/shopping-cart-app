class CartsController < ApplicationController
  ## TODO Escreva a lógica dos carrinhos aqui

  def show
    binding.pry
    render json: { id: current_cart.uuid }
  end

  def update
    render json: { PING: 'PONG' }
  end

  # QUAL É EXATAMENTE O SENTIDO DESSE ENDPOINT?
  def add_item
    'PONG'
  end
end
