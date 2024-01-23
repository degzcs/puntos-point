class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchase_customers do |t|
      t.references :product
      t.references :customer
      t.decimal :total
      t.integer :quantity

      t.timestamps
    end

    add_index :purchase_customers, :product_id
    add_index :purchase_customers, :customer_id
  end

  def self.down
    drop_table :purchase_customers
  end
end
