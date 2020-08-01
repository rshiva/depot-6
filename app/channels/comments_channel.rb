class CommentsChannel < ApplicationCable::Channel
  def subscribed
    print("----",params)
    stream_from "products_#{params[:product_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
