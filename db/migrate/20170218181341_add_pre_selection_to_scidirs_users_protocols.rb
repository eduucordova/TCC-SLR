class AddPreSelectionToScidirsUsersProtocols < ActiveRecord::Migration
  def change
    add_column :scidirs_users_protocols, :pre_selection, :boolean
  end
end
