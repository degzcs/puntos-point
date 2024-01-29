class PurchaseMailer < ActionMailer::Base
  default from: "info@example.com"

  def first_purchase(admin, other_admins, customer_name)
    @admin = admin
    @customer_name = customer_name
    other_admins = other_admins
    cc = other_admins.map(&:email).join(',')

    mail to: admin.email, cc: cc, othesubject: "First purchase"
  end

  def daily_report(purchases)
    @emails = Admin.all.map(&:email).join(',')
    @purchases = purchases

    mail to: @emails, subject: "Daily report"
  end
end

