class CommentsController < ActionController::Base
  before_action :find_product

  def create
    @comment = @product.comments.create(comment_params)
    AddCommentJob.perform_later(@comment, @product)
    # redirect_to @product
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end
end