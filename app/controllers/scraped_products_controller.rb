class ScrapedProductsController < ApplicationController
  before_action :set_scraped_product, only: [:show, :edit, :update, :destroy]

  # GET /scraped_products
  # GET /scraped_products.json
  def index
    @scraped_products = ScrapedProduct.all
    if params[:product_type]
      @scraped_products = @scraped_products.select { |p| p.product_type == params[:product_type] }
    end
  end

  # GET /scraped_products/1
  # GET /scraped_products/1.json
  def show
  end

  # GET /scraped_products/new
  def new
    @scraped_product = ScrapedProduct.new
  end

  # GET /scraped_products/1/edit
  def edit
  end

  # POST /scraped_products
  # POST /scraped_products.json
  def create
    @scraped_product = ScrapedProduct.new(scraped_product_params)

    respond_to do |format|
      if @scraped_product.save
        format.html { redirect_to @scraped_product, notice: 'Scraped product was successfully created.' }
        format.json { render :show, status: :created, location: @scraped_product }
      else
        format.html { render :new }
        format.json { render json: @scraped_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scraped_products/1
  # PATCH/PUT /scraped_products/1.json
  def update
    respond_to do |format|
      if @scraped_product.update(scraped_product_params)
        format.html { redirect_to @scraped_product, notice: 'Scraped product was successfully updated.' }
        format.json { render :show, status: :ok, location: @scraped_product }
      else
        format.html { render :edit }
        format.json { render json: @scraped_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scraped_products/1
  # DELETE /scraped_products/1.json
  def destroy
    @scraped_product.destroy
    respond_to do |format|
      format.html { redirect_to scraped_products_url, notice: 'Scraped product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scraped_product
      @scraped_product = ScrapedProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scraped_product_params
      params.require(:scraped_product).permit(:name, :price, :day_scraped, :manufacturer)
    end
end
