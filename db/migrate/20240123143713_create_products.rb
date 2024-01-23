class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :type
      t.decimal :price

      t.timestamps
    end
  end
end
