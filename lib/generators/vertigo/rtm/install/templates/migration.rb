class AddVertigoRtmStatusTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def self.up
    add_column :<%= table_name %>, :vertigo_rtm_status, :integer, default: 0
  end

  def self.down
    remove_column :<%= table_name %>, :vertigo_rtm_status
  end
end
