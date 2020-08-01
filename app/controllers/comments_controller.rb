class CommentsController < ActionController::Base
  before_action :find_product

  def create
    # byebug
    @comment = @product.comments.create(comment_params)

    html = render(partial: "comments/comment", locals: {comment: @comment}, layout: false)

    ActionCable.server.broadcast "products_#{@product.id}", html: html

    # format.html { redirect_to product_path(@product) }
    # format.json { render :show, status: :ok, location: @product }
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end