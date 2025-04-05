class ApplicationController < ActionController::API
  include ActionController::Cookies

  def current_cart
    @current_cart ||= Cart.find_by(uuid: cookies.signed[:cart_uuid]) || create_cart
  end
  
  def create_cart
    cart = Cart.create(total_price: 0)

    if cookies.signed[:cart_uuid].blank?
      cookies.signed[:cart_uuid] = {
        value: cart.uuid,
        expires: 1.week.from_now,
        httponly: true
      }
    end

    cart
  end
  
end
