class ReportWorker
  include Sidekiq::Worker

  def perform
    service = PurchaseReporter.new
    service.call
  end
end
