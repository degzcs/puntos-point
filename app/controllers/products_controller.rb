class ProductsController < ApplicationController
  def top_products_by_category
    @products = Product.top_products_by_category
    render json: @products.map(&:attributes)
  end

  def top_best_sellers_by_category
    limit = params[:limit] || 3
    @products = Product.top_best_sellers_by_category(limit)
    render json: @products.map(&:attributes)
  end
end
