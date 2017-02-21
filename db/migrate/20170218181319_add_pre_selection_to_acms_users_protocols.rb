class AddPreSelectionToAcmsUsersProtocols < ActiveRecord::Migration
  def change
    add_column :acms_users_protocols, :pre_selection, :boolean
  end
end
