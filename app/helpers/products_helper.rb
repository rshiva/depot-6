module ProductsHelper

  def product_edit_by_admin(product)
    if current_user?
      link_to 'Edit', edit_product_path(product)
    end
  end
end
