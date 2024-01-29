class Customer < ActiveRecord::Base
  audited
  has_many :purchases

  validate :id_number, presence: true, uniqueness: true
end
