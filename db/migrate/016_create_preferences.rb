class CreatePreferences < ActiveRecord::Migration
  def self.up
    # drop_table :preferences rescue nil
    create_table :preferences do |t|
      t.string :domain, :null => false, :default => ""
      t.string :smtp_server, :null => false, :default => ""
      t.boolean :email_notifications, :null => false, :default => false
      t.boolean :email_verifications, :null => false, :default => false
	  t.boolean :smtp_auth, :null => false, :default => false
	  t.string :smtp_server_username, :null => false, :default => ""
      t.string :smtp_server_password, :null => false, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end
