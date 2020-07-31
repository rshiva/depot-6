class StoreController < ApplicationController
  skip_before_action :authorize
  include StoreVisit
  include CurrentCart
  before_action :increment_visit_count, only: :index
  before_action :set_cart


  def index
    @products = Product.order(:title)
    @visit_counter = session[:counter] 
  end

end