class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :springers_users_protocols, :pre_selection, :pre_selected
    rename_column :scopus_users_protocols, :pre_selection, :pre_selected
    rename_column :scidirs_users_protocols, :pre_selection, :pre_selected
    rename_column :acms_users_protocols, :pre_selection, :pre_selected
    rename_column :ieees_users_protocols, :pre_selection, :pre_selected
  end
end
