class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  before_save :calculate_total

  validates :product_id, :customer_id, :quantity, presence: true

  scope :all_persisted, lambda { where("purchases.id IS NOT NULL") }
  scope :start_at, lambda { |start_date|
    where("purchases.created_at >= ?",
          start_date.to_time.beginning_of_day)
  }
  scope :end_at, lambda { |end_date|
    where("purchases.created_at <= ?", end_date.to_time.end_of_day)
  }
  scope :range, lambda { |start_date, end_date| start_at(start_date).end_at(end_date) }
  scope :by_customer_id, lambda { |customer_id| where(customer_id: customer_id) }
  scope :by_category_id, lambda { |category_id|
    joins(product: :product_categories)
    .where("product_categories.category_id = ?", category_id)
  }
  # scope :by_admin_id : audit system
  scope :by_granularity, lambda { |granularity|
    select("date_trunc('#{granularity}', purchases.created_at) as purchase_granularity, count(*) as purchase_count").group('purchase_granularity')
  }

  private

  def calculate_total
    self.total = quantity * product.price
  end
end
