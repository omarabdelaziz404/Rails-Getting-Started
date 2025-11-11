# Controller
class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]

  def index 
  # index method is an Action. 
  # index action will render app/views/products/index.html.erb
    @products = Product.all # fetch all rows from the products table, and assign it to an instance variable @
  end

  def show # Showing Individual Products
  end
  
  def new
    @product = Product.new # instantiates a new Product
  end

  def create # builds a new product with form data.
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

  def product_params
    params.expect(product: [ :name ])
  end
end

