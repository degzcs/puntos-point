class Category < ActiveRecord::Base
  has_and_belongs_to_many :products, join_table: :product_categories
  #belongs_to :admin, class_name: "Admin", foreign_key: "admin_id"
end
