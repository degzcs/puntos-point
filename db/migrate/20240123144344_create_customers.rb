class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :first_name
      t.string :last_name
      t.text :id_number

      t.timestamps
    end
  end
end
