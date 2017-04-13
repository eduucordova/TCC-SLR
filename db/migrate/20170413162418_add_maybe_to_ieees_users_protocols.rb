class AddMaybeToIeeesUsersProtocols < ActiveRecord::Migration
  def change
    add_column :ieees_users_protocols, :maybe, :boolean
  end
end
