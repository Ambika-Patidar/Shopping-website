ActionMailer::Base.delivery_method=:smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "gmail.com",
  :authentication => :login,
  :user_name => "ambika.patidar.cse@gmail.com",
  :password => "ambspatidar",
  :enable_starttls_auto => true
}
ActionMailer::Base.perform_deliveries = true 
ActionMailer::Base.raise_delivery_errors = true 
ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.default :content_type => "text/html"
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
