class CommentsController < ActionController::Base
  before_action :find_product

  def create
    # byebug
    @comments = @product.comments.create(comment_params)
    redirect_to product_path(@product)
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end