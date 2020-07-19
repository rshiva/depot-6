class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :increment, :decrement]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy,]
  after_action :reset_session_counter


  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    #@line_item = LineItem.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to store_index_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def increment
    @current_item = @cart.line_items.find_by(id: params[:id])
    @current_item.quantity +=1 if @current_item
    respond_to do |format|
      if @current_item.save!
        format.html { redirect_to store_index_url}
        format.json { head :no_content }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
      
  end

  def decrement
    @current_item = @cart.line_items.find_by(id: params[:id])
    @current_item.quantity -=1 if @current_item
    respond_to do |format|
      if @current_item.save!
        format.html { redirect_to store_index_url}
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

    def reset_session_counter
      session[:counter] = nil
    end

end
