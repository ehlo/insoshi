class AddSenderIpCommunications < ActiveRecord::Migration
  def self.up
    add_column :communications, :sender_ip, :string
  end

  def self.down
    remove_column :communications, :sender_ip, :string
  end
end