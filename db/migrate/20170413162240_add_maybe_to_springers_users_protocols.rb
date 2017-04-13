class AddMaybeToSpringersUsersProtocols < ActiveRecord::Migration
  def change
    add_column :springers_users_protocols, :maybe, :boolean
  end
end
