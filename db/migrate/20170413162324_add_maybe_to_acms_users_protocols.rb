class AddMaybeToAcmsUsersProtocols < ActiveRecord::Migration
  def change
    add_column :acms_users_protocols, :maybe, :boolean
  end
end
