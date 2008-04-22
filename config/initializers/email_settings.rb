begin
  unless test?
    global_prefs = Preference.find(:first)
    if global_prefs.email_notifications?
      ActionMailer::Base.delivery_method = :smtp
		if global_prefs.smtp_auth?
		  ActionMailer::Base.smtp_settings = {
			:address    => global_prefs.smtp_server,
			:port       => 25,
			:domain     => global_prefs.domain,
			:user_name => global_prefs.smtp_server_username,
			:password => global_prefs.smtp_server_password,
			:authentication => :login
		  }
		else
		  ActionMailer::Base.smtp_settings = {
			:address    => global_prefs.smtp_server,
			:port       => 25,
			:domain     => global_prefs.domain
		  }
		end
    end
  end
rescue
  # Rescue from the error raised upon first migrating
  # (needed to bootstrap the preferences).
  nil
end