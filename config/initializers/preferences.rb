# Return domain for emails
EMAIL_DOMAIN = "example.ch"

# Address for SMTP server
SMTP_SERVER = "mail.example.ch"

#SMTP Auth ?
SMTP_AUTH = true
SMTP_SERVER_USERNAME = "user@example.ch"
SMTP_SERVER_PASSWORD = "password" 

# Allow delivery of email notifications for messages and contact requests?
# Always true in test mode.
# Set second value to true to enable notifications.
EMAIL_NOTIFICATIONS = test? ? true : true

unless test?
  ActionMailer::Base.delivery_method = :smtp

  if !SMTP_AUTH
	ActionMailer::Base.smtp_settings = {
		:address    => SMTP_SERVER,
		:port       => 25,
		:domain     => EMAIL_DOMAIN,
	}
  else
	ActionMailer::Base.smtp_settings = {
		:address    => SMTP_SERVER,
		:port       => 25,
		:domain     => EMAIL_DOMAIN,
		:user_name  => SMTP_SERVER_USERNAME,
		:password  => SMTP_SERVER_PASSWORD,
		:authentication  => :login
	}
  end
end