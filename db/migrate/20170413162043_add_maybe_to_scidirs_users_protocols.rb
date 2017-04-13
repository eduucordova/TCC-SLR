class AddMaybeToScidirsUsersProtocols < ActiveRecord::Migration
  def change
    add_column :scidirs_users_protocols, :maybe, :boolean
  end
end
