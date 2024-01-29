require 'sidekiq-scheduler'

class ReportWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default

  def perform
    service = PurchaseReporter.new
    service.call
  end
end
