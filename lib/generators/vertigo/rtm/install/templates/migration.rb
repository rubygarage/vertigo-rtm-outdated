class AddVertigoRtmTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def self.up
    add_column :<%= table_name %>, :state, :integer, default: 0
  end

  def self.down
    remove_column :<%= table_name %>, :state
  end
end
