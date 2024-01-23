class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.references :product
      t.references :customer
      t.decimal :total
      t.integer :quantity

      t.timestamps
    end

    add_index :purchases, :product_id
    add_index :purchases, :customer_id
  end

  def self.down
    drop_table :purchases
  end
end
