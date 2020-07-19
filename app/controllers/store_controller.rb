class StoreController < ApplicationController
  include StoreVisit
  before_action :increment_visit_count, only: :index


  def index
    @products = Product.order(:title)
    @visit_counter = session[:counter] 
  end
end