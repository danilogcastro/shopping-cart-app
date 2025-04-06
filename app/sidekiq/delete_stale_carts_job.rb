class DeleteStaleCartsJob
  include Sidekiq::Job

  def perform(*args)
    # PREFERI SEPARAR OS JOBS
    stale_carts = Cart.where("last_interaction_at <  ?", 7.days.ago)
    cart_ids = stale_carts.pluck(:id)

    # REMOVER OS ITENS RELACTIONADOS
    Item.where(cart_id: cart_ids).delete_all
    # REMOVER OS CARRINHOS
    # OPTEI POR USAR O delete_all POR ESTE FAZER A REMOÇÃO
    # DIRETO NA BASE DE DADOS, SENDO ASSIM MAIS EFICIENTE
    stale_carts.delete_all
  end
end
