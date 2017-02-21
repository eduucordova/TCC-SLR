class AddPreSelectionToIeeesUsersProtocols < ActiveRecord::Migration
  def change
    add_column :ieees_users_protocols, :pre_selection, :boolean
  end
end
