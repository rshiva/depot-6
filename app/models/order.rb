require 'pago'
class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :support_requests
  
  enum pay_type: {
    "Check" => 0,
    "Credit Card" => 1,
    "Purchase Order" => 2
  }
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end


  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil

    case pay_type
    when "Check"
      payment_method = :check
      payment_details[:routing] =  pay_type_params[:routing_number]
      payment_details[:account] = payment_details[:account_number]
    when "Credit Card"
      payment_method = :credit_card
      month,year = pay_type_params[:expiration_date].split(//)
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] =  month
      payment_details[:expiration_year] =  year
    when "Purchase Order"
      payment_method = :po
      payment_details[:po_num] = pay_type_params[:po_number]
    end
    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )
  end
end
