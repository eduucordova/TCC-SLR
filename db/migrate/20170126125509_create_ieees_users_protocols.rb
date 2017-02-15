class CreateIeeesUsersProtocols < ActiveRecord::Migration
  def change
    create_table :ieees_users_protocols do |t|
      t.references :ieee, index: true, foreign_key: { on_delete: :cascade }
      t.references :users_protocol, index: true, foreign_key: { on_delete: :cascade }
      t.boolean :included
    end
  end
end
