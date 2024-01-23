class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories, id: false do |t|
      t.references :product
      t.references :category

      t.timestamps
    end

    add_index :product_categories, :product_id
    add_index :product_categories, :category_id
  end

  def self.down
    drop_table :product_categories
  end
end
