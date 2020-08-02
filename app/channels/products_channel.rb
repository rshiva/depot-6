class ProductsChannel < ApplicationCable::Channel
  def subscribed
    print("----",params)
    stream_from "products_#{params[:product_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def appear
    @product = Product.find(params[:product_id])
    ActionCable.server.broadcast("products_#{params[:product_id]}", message: @product)
  end
end
