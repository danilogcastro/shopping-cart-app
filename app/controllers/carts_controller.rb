class CartsController < ApplicationController
  def show
    render :show, locals: { cart: current_cart }
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

  def delete_item
    @item = Item.find_by(product_id: item_params[:product_id], cart_id: current_cart.id)

    return render json: { error: "Carrinho não possui este produto" } if @item.blank?

    if @item.destroy
      render :delete_item, locals: { cart: current_cart }
    else
      render json: { error: "Não foi possível remover item do carrinho"}
    end
  end

  # ENDPOINT ME PARECE REDUNDANTE
  # NÃO VEJO DIFERENÇA DE COMPORTAMENTO
  # EM RELAÇÃO À ACTION update
  def add_item
    # TODO
  end

  private

  def item_params
    params.permit(:product_id, :quantity)
  end
end
