require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PreferencesController do

  describe "authentication" do
    it "should require admin to access" do
      login_as :quentin
      get :index
      response.should redirect_to(home_url)
    end
  
    it "should allow an admin to access" do
      login_as :admin
      get :index
      response.should be_success
    end
  end

  describe "changing preferences" do
    integrate_views
    
    before(:each) do
      @prefs = Preference.find(:first)
      login_as :admin
    end
    
    it "should render messages for email notification error" do
      put :update, :preferences => { :smtp_server => "", :domain => "", 
                                     :email_notifications => "1" }
      response.body.should =~ /errorExplanation/
    end
    
    it "should update email notifications" do
      @prefs.email_notifications = false
      @prefs.save!
      @prefs.email_notifications.should be_false
      put :update, :preferences => { :smtp_server => @prefs.smtp_server,
                                     :domain => @prefs.domain, 
                                     :email_notifications => "1" }
      @prefs.reload.email_notifications.should be_true
    end
    
    it "should update email verifications" do
      @prefs.email_verifications = false
      @prefs.save!
      put :update, :preferences => { :email_verifications => "1" }
      @prefs.reload.email_verifications.should be_true
    end
    
    it "should have a flash warning if the SMTP server changes" do
      put :update, :preferences => { :smtp_server => "new-smtp.server",
                                     :domain => @prefs.domain, 
                                     :email_notifications => "1" }
      flash[:error].should_not be_nil
    end
    
    it "should have a flash warning if the email domain changes" do
      put :update, :preferences => { :smtp_server => @prefs.smtp_server,
                                     :domain => "new-example.com", 
                                     :email_notifications => "1" }
      flash[:error].should_not be_nil
    end
	
	it "should render messages for smtp auth error" do
      put :update, :preferences => { :smtp_server => "smtp.example.com", :domain => "example.com", 
                                     :email_notifications => "1", :smtp_auth => "1", :smtp_server_username => "bozo", :smtp_server_password => ""}
      response.body.should =~ /errorExplanation/
    end
  
    it "should update the analytics attribute" do
      put :update, :preferences => { :analytics => "Google analytics" }
      @prefs.reload.analytics.should == "Google analytics"
    end

	it "should render messages for smtp auth error" do
      put :update, :preferences => { :smtp_server => "smtp.example.com", :domain => "example.com", 
                                     :email_notifications => "1", :smtp_auth => "1", :smtp_server_username => "", :smtp_server_password => "password"}
      response.body.should =~ /errorExplanation/
    end
	it "should render messages for smtp auth error" do
      put :update, :preferences => { :smtp_server => "smtp.example.com", :domain => "example.com", 
                                     :email_notifications => "1", :smtp_auth => "1", :smtp_server_username => "", :smtp_server_password => ""}
      response.body.should =~ /errorExplanation/
    end
	it "should render messages for smtp auth error" do
      put :update, :preferences => { :smtp_server => "", :domain => "", 
                                     :email_notifications => "", :smtp_auth => "1", :smtp_server_username => "bozzo", :smtp_server_password => "password"}
      response.body.should =~ /errorExplanation/
    end

    it "should update smtp auth" do
      @prefs.smtp_auth = false
      @prefs.save!
      @prefs.smtp_auth.should be_false
      put :update, :preferences => { :smtp_server => "smtp.example.com",
                                     :domain => "example.com", 
                                     :email_notifications => "1",
									 :smtp_auth =>  "1",
									 :smtp_server_username => "username",
									 :smtp_server_password => "password"
									 }
      @prefs.reload.smtp_auth.should be_true
    end

	it "should update smtp password" do
      @prefs.smtp_auth = false
      @prefs.smtp_server_username = false
      @prefs.smtp_server_password = false
      @prefs.save!
      @prefs.smtp_server_password.should be_false
      put :update, :preferences => { :smtp_server => "smtp.example.com",
                                     :domain => "example.com", 
                                     :email_notifications => "1",
									 :smtp_auth =>  "1",
									 :smtp_server_username => "username",
									 :smtp_server_password => "password"
									 }
      @prefs.reload.smtp_server_password.should == "password"
    end
	
    it "should have a flash warning if the smtp auth username changes" do
      put :update, :preferences => { :smtp_server => @prefs.smtp_server,
                                     :domain => @prefs.domain, 
                                     :email_notifications => @prefs.email_notifications,
									 :smtp_auth =>  @prefs.smtp_auth,
									 :smtp_server_username => "newUsername",
									 :smtp_server_password => @prefs.smtp_server_password
									 }
      flash[:error].should_not be_nil
    end

    it "should have a flash warning if the smtp auth password changes" do
      put :update, :preferences => { :smtp_server => @prefs.smtp_server,
                                     :domain => @prefs.domain, 
                                     :email_notifications => @prefs.email_notifications,
									 :smtp_auth =>  @prefs.smtp_auth,
									 :smtp_server_username => @prefs.smtp_server_username,
									 :smtp_server_password => "newPassword"
									 }
      flash[:error].should_not be_nil
    end

  end
end