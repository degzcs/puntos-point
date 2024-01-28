class Photo < ActiveRecord::Base
  audited
  attr_accessible :gallery_id, :name, :image
  belongs_to :photoable, polymorphic: true
  mount_uploader :image, ImageUploader
end
