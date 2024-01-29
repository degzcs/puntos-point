class PurchaseProcessor < BaseService
  attr_reader :purchase, :current_admin

  def initialize(purchase, current_admin)
    @purchase = purchase
    @current_admin = current_admin
    super()
  end

  def call
    @errors << purchase.errors.full_messages unless purchase.valid?

    Audited.audit_class.as_user(current_admin) do
      # check if it is the first purchase for a customer
      number_of_purchases = Purchase.by_customer_id(purchase.customer_id).count
      if number_of_purchases.zero?
        customer_name = purchase.customer.first_name
        PurchaseMailer.first_purchase(current_admin, other_admins, customer_name).deliver
      end

      purchase.save
      @result = purchase
    end
  end

  private

  def other_admins
    Admin.other_admins(current_admin.id)
  end
end
