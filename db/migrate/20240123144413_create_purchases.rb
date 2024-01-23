class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchase_customers do |t|
      t.references :products
      t.references :customers
      t.decimal :total
      t.integer :quantity

      t.timestamps
    end

    add_index :purchase_customers, :product_id
    add_index :purchase_customers, :customer_id
  end
end
