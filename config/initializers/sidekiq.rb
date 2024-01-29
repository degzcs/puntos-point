require "sidekiq-scheduler"

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://cache:6379/0' }
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../scheduler.yml', __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://cache:6379/0' }
end
