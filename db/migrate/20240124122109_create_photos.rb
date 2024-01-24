class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.text :image
      t.integer :photoable_id
      t.string :photoable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
