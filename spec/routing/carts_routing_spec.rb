require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe 'routes' do
    it 'routes to #show' do
      expect(get: '/cart').to route_to('carts#show')
    end

    it 'routes to #create' do
      expect(post: '/cart').to route_to('carts#create')
    end

    it 'routes to #add_item via PATCH' do
      expect(patch: '/cart/add_item').to route_to('carts#update')
    end

    it 'routes to #delete_item via DELETE' do
      expect(delete: '/cart/3').to route_to(controller: 'carts', action: 'delete_item', product_id: '3')
    end
  end
end 
