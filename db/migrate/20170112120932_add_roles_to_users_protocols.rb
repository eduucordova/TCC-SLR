class AddRolesToUsersProtocols < ActiveRecord::Migration
  def change
    add_reference :users_protocols, :role, index: true, foreign_key: true
  end
end
