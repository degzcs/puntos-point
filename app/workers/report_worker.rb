class ReportWorker
  include Sidekiq::Worker

  def perform
    puts "I'm in the worker"
    `touch /tmp/worker.txt`
  end
end
