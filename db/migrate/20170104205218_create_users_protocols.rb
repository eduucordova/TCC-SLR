class CreateUsersProtocols < ActiveRecord::Migration
  def change
    create_table :users_protocols do |t|
      t.references :user, index: true, foreign_key: true
      t.references :protocol, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
