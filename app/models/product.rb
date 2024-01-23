class Product < ActiveRecord::Base
  has_and_belongs_to_many  :categories, join_table: :product_categories
  has_many :purchases
  #belongs_to :admin, class_name: "Admin", foreign_key: "admin_id"
end
