class Customer < ActiveRecord::Base
  audited
  has_many :purchases
end
