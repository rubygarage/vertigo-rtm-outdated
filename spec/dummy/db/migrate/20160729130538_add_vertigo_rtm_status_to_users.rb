class AddVertigoRtmStatusToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :vertigo_rtm_status, :integer, default: 0
  end

  def self.down
    remove_column :users, :vertigo_rtm_status
  end
end
