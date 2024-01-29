class PurchaseReporter < BaseService
  def call
    begin
      purchases = Purchase.from_yesterday
      send_report(purchases)
    rescue => e
      @errors << { message: e.message }
    end
  end

  private

  def send_report(purchases)
    PurchaseMailer.daily_report(purchases).deliver
  end
end
