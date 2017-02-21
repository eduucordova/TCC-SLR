class AddPreSelectionToSpringersUsersProtocols < ActiveRecord::Migration
  def change
    add_column :springers_users_protocols, :pre_selection, :boolean
  end
end
