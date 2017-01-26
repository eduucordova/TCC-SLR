class RemoveUserFromProtocols < ActiveRecord::Migration
  def change
    remove_reference :protocols, :user, index: true
  end
end
