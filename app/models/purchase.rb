class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  before_save :calculate_total

  validates :product_id, :customer_id, :quantity, presence: true

  private

  def calculate_total
    self.total = quantity * product.price
  end
end
