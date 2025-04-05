class CartsController < ApplicationController
  ## TODO Escreva a lógica dos carrinhos aqui

  def show
    render json: { id: current_cart.uuid }
  end
  
  def update
    @item = Item.find_or_initialize_by(product_id: item_params[:product_id], cart_id: current_cart.id)
    @item.quantity += item_params[:quantity]

    if @item.save
      render :update, locals: { cart: current_cart }
    else
      render json: { error: @item.errors.full_messages, status: :unprocessable_entity }
    end
  end

  # QUAL É EXATAMENTE O SENTIDO DESSE ENDPOINT?
  def add_item
    'PONG'
  end

  private

  def item_params
    params.permit(:product_id, :quantity)
  end
end
