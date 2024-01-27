class ProductsController < ApplicationController

  def top_products_by_category
    @products = Product.top_products_by_category
    render json: @products
  end
end
