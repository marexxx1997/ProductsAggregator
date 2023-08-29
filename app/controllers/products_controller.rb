class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = if params[:search]
                  Product.where("name ILIKE ?", "%#{params[:search]}%")
                else
                  Product.all
                end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        Platform.all.each do |platform|
          # // kreirati platform_product
          platform_product = PlatformProduct.create(
            url: platform.url,
            # state: "initialized",
            product_id: @product.id,
            platform_id: platform.id
          )
          # // job za taj platfrom_product
          # platform_product.state_machine.transition_to!(:initialized)
          ProcessPlatformJob.perform_later(platform_product.id)
        end
        
        format.html { redirect_to products_url, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def accept_candidate
    platform_product = PlatformProduct.find(params[:platform_product_id])
    platform_product.transition_to!(:approved)
    notice_message = "Candidate approved."
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name)
    end
end
