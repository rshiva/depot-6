module CurrentCart

  private

  def set_cart
    begin
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart =  Cart.create
      session[:cart_id] = @cart.id
    end
    print "--session--",session[:cart_id]
  end
end