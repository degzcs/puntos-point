class Category < ActiveRecord::Base
  audited
  belongs_to :product
  has_and_belongs_to_many :products, join_table: :product_categories

  validates :name, presence: true, uniqueness: true
end
