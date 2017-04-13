class AddMaybeToScopusUsersProtocols < ActiveRecord::Migration
  def change
    add_column :scopus_users_protocols, :maybe, :boolean
  end
end
