begin
  unless test?
    global_prefs = Preference.find(:first)
    if global_prefs.email_notifications?
      ActionMailer::Base.delivery_method = :smtp
    if global_prefs.smtp_auth?
     ActionMailer::Base.smtp_settings = {
      :address => global_prefs.smtp_server,
      :port => global_prefs.smtp_server_port,
      :domain => global_prefs.domain,
      :user_name => global_prefs.smtp_server_username,
      :password => global_prefs.smtp_server_password,
      :authentication => :login,
	  :tls => global_prefs.smtp_server_tls
     }
    else
     ActionMailer::Base.smtp_settings = {
      :address => global_prefs.smtp_server,
      :port => global_prefs.smtp_server_port,
      :domain => global_prefs.domain,
	  :tls => global_prefs.smtp_server_tls
     }
    end
    end
  end
rescue
  # Rescue from the error raised upon first migrating
  # (needed to bootstrap the preferences).
  nil
end