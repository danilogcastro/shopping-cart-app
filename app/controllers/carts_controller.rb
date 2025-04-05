class CartsController < ApplicationController
  ## TODO Escreva a lógica dos carrinhos aqui

  def show
    render json: { PING: 'PONG' }
  end

  def update
    render json: { PING: 'PONG' }
  end

  # QUAL É EXATAMENTE O SENTIDO DESSE ENDPOINT?
  def add_item
    'PONG'
  end
end
