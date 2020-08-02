class AddCommentJob < ApplicationJob
  queue_as :default

  def perform(comment, product)
    # Do something later
    html = ApplicationController.render(partial: "comments/comment", locals: {comment: comment}, layout: false)
    ActionCable.server.broadcast "products_#{product.id}", html: html
  end
end
