class PurchaseMailer < ActionMailer::Base
  default from: "info@example.com"

  def first_purchase(admin, other_admins, customer_name)
    @admin = admin
    @customer_name = customer_name
    other_admins = other_admins
    cc = other_admins.map(&:email)

    mail to: admin.email, cc: cc, othesubject: "First purchase"
  end
end
