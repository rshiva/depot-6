class MoveProductPriceToLineItems < ActiveRecord::Migration[6.0]
  def up
    Cart.all.each do |cart|
      cart.line_items.each do |item|
        item.price = item.product.price
        item.save!
      end
    end
  end

  def down
    Cart.all.each do |cart|
      cart.line_items.each do |item|
        item.price = nil
        item.save!
      end
    end
  end
end
