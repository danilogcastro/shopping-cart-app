require 'rails_helper'

RSpec.describe "/carts", type: :request do
  describe "PATCH /add_item" do
    let!(:cart) { create(:shopping_cart) }
    let!(:product) { create(:product) }
    let!(:cart_item) { create(:item, cart: cart, product: product, quantity: 1) }
    let!(:headers) do
      signed_cookie = sign_cookie(:cart_uuid, cart.uuid)
      {
        'Cookie' => signed_cookie
      }
    end

    context 'when the product already is in the cart' do
      subject do
        patch '/cart/add_item', params: { product_id: product.id, quantity: 1 }, headers: headers, as: :json
        patch '/cart/add_item', params: { product_id: product.id, quantity: 1 }, headers: headers, as: :json
      end

      it 'updates the quantity of the existing item in the cart' do
        expect { subject }.to change { cart_item.reload.quantity }.by(2)
      end
    end
  end

  describe "POST /cart" do
    let!(:product) { create(:product) }

    context 'when cart does not exist' do
      subject do
        post '/cart', params: { product_id: product.id, quantity: 1 }, as: :json
      end

      it 'creates a new cart and adds product to cart' do
        expect { subject }.to change { Cart.count }.by(1).and change { Item.count }.by(1)
      end
    end
  end

  describe "DELETE /cart/:product_id" do
    let!(:cart) { create(:shopping_cart) }
    let!(:product) { create(:product) }
    let!(:cart_item) { create(:item, cart: cart, product: product, quantity: 1) }
    let!(:headers) do
      signed_cookie = sign_cookie(:cart_uuid, cart.uuid)
      {
        'Cookie' => signed_cookie
      }
    end

    context 'when product exists in cart' do
      subject do
        delete "/cart/#{product.id}", headers: headers, as: :json
      end

      it 'removes product from cart' do
        expect { subject }.to change { Item.count }.by(-1)
      end
    end

    context 'when product does not exist in cart' do
      it 'returns correct error message' do
        delete "/cart/999999999", headers: headers, as: :json

        response_body = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(response_body['error']).to eq("Carrinho não possui este produto")
      end
    end
  end
end
