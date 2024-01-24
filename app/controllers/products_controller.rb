class ProductsController < ApplicationController
  def top
    @products = Category.find(params[:category_id]).products.top
    render json: @products
  end
end
