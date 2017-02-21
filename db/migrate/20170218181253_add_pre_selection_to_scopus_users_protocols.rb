class AddPreSelectionToScopusUsersProtocols < ActiveRecord::Migration
  def change
    add_column :scopus_users_protocols, :pre_selection, :boolean
  end
end
