class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('mailer.default_email_from')
  layout 'mailer'
end
