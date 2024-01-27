class Product < ActiveRecord::Base
  self.inheritance_column = 'sty_type'

  has_and_belongs_to_many  :categories, join_table: :product_categories
  has_many :product_categories
  has_many :purchases
  has_many :photos, as: :photoable

  validates :name, presence: true, uniqueness: true

  #
  # Class methods
  #

  # This method is used to find the number of purchases for each product in each category.
  # It is used in the next method (categories_and_max_purchase) to find the maximum number of purchases for each category.
  # It is also used in the method after that (top_products_by_category) to find the top product for each category.
  def self.purchase_count_by_category
    Purchase.select("purchases.product_id, product_categories.category_id, COUNT(purchases.id) as purchase_count")
      .joins("INNER JOIN product_categories ON purchases.product_id = product_categories.product_id")
      .group("purchases.product_id, product_categories.category_id")
  end

  # This method is used to find the maximum number of purchases for each category.
  # It is used in the next method to find the top product for each category.
  def self.categories_and_max_purchases
    ProductCategory.select("product_categories.category_id, MAX(prod_and_category.purchase_count) as max_purchase_count")
      .joins("INNER JOIN (#{purchase_count_by_category.to_sql}) AS prod_and_category ON product_categories.product_id = prod_and_category.product_id")
      .group("product_categories.category_id")
  end

  # This method is used to find the top product for each category.
  # It is used in the controller to display the top product for each category.
  def self.top_products_by_category
    query = Product.select("products.*")
      .joins("INNER JOIN (#{purchase_count_by_category.to_sql}) AS prod_and_category ON products.id = prod_and_category.product_id")
      .where("(prod_and_category.category_id, prod_and_category.purchase_count) IN (#{categories_and_max_purchases.to_sql})")

    Product.find_by_sql(query.to_sql)
  end

  #
  # Instance methods
  #
end
