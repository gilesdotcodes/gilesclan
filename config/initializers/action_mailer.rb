# config/initializers/action_mailer.rb
if Rails.env.development?
  # Define settings for mailcatcher
  Rails.application.config.action_mailer.tap do |action_mailer|
    action_mailer.delivery_method = :letter_opener
    action_mailer..perform_deliveries = true
    action_mailer.asset_host = 'http://localhost:3000'
    action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  end
end

if Rails.env.production?
  # Define settings for sendgrid
  Rails.application.config.action_mailer.tap do |action_mailer|
    action_mailer.delivery_method = :smtp
    action_mailer.perform_deliveries = true
    action_mailer.asset_host = 'http://www.gilesclan.me.uk'
    action_mailer.default_url_options = { host: ENV['ACTION_MAILER_HOST'] }
    action_mailer.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      domain: 'gilesclan.me.uk',
      enable_starttls_auto: true
    }
  end
end
