class AddSelectionSubmittedToUsersProtocols < ActiveRecord::Migration
  def change
    add_column :users_protocols, :selection_submitted, :boolean
  end
end
