class CreateSpringersUsersProtocols < ActiveRecord::Migration
  def change
    create_table :springers_users_protocols do |t|
      t.references :springer, index: true, foreign_key: { on_delete: :cascade }
      t.references :users_protocol, index: true, foreign_key: { on_delete: :cascade }
      t.boolean :included
    end
  end
end
