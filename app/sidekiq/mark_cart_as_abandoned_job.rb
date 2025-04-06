class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*args)
    abandoned_carts = Cart.where("status = 0 AND last_interaction_at <  ?", 3.hours.ago)

    abandoned_carts.update_all(status: 'abandoned')
  end
end
