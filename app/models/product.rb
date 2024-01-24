class Product < ActiveRecord::Base
  self.inheritance_column = 'something_else'

  has_and_belongs_to_many  :categories, join_table: :product_categories
  has_many :purchases
  has_many :photos, as: :photoable

  scope :top, -> { order('price DESC').limit(5) }
end
