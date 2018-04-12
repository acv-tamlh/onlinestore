PayPal::SDK::Core::Config.load('config/paypal.yml', 'development')
# PayPal::SDK.logger = Rails.logger
PayPal::SDK.logger.level = Logger::INFO
