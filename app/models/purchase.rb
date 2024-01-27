class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  before_save :calculate_total

  validates :product_id, :customer_id, :quantity, presence: true

  scope :start_at, lambda { |start_date|  where("created_at >= ?", start_date) }
  scope :end_at, lambda { |end_date| where("created_at <= ?", end_date) }
  scope :range, lambda { |start_date, end_date| start_at(start_date).end_at(end_date) }
  scope :by_customer, lambda { |customer_id| where(customer_id: customer_id) }
  scope :by_category, lambda { |category_id|
    joins(product: :product_categories)
    .where("product_categories.category_id = ?", category_id)
  }
  # scope :by_admin : audit system

  private

  def calculate_total
    self.total = quantity * product.price
  end
end
