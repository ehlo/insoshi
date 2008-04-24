# == Schema Information
# Schema version: 19
#
# Table name: preferences
#
#  id                  :integer         not null, primary key
#  domain              :string(255)     default(""), not null
#  smtp_server         :string(255)     default(""), not null
#  email_notifications :boolean         not null
#  email_verifications :boolean         not null
#  created_at          :datetime        
#  updated_at          :datetime        
#  analytics           :text            
#  server_name         :string(255)     
#  app_name            :string(255)     
#

class Preference < ActiveRecord::Base
  attr_accessible :app_name, :server_name, :domain, :smtp_server, 
                  :email_notifications, :email_verifications, :analytics,
				  :smtp_auth, :smtp_server_username, :smtp_server_password,
				  :smtp_server_port, :smtp_server_tls

  validates_presence_of :domain,       :if => :using_email?
  validates_presence_of :smtp_server,  :if => :using_email?
  validates_presence_of :smtp_server_port,  :if => :using_email?
  validates_presence_of :smtp_server,  :if => :using_smtpauth?
  validates_presence_of :smtp_server_username,  :if => :using_smtpauth?
  validates_presence_of :smtp_server_password,  :if => :using_smtpauth?

  private
  
    def using_email?
      email_notifications? or email_verifications?
    end
	
	def using_smtpauth?
	  smtp_auth?
	end

end
