if Rails.env.production?
  Holywood::Application.config.middleware.use ExceptionNotifier,
    email_prefix: "[#{Settings.app_name} #{Rails.env}] ",
    sender_address: %{"Exception Notifier" <info@incodewetrust.com>},
    exception_recipients: %w{mail@dennisreimann.de}
end