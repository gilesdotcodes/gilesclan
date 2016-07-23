namespace :notifications do
  desc "Send On This Day Email where appropriate"
  task(on_this_day: :environment) do
    BiographyEvent.send_daily_notification if BiographyEvent.on_this_day.any?
  end
end
