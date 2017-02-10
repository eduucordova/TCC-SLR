class CreateIeeesUsersProtocols < ActiveRecord::Migration
  def change
    create_table :ieees_users_protocols do |t|
      t.references :ieee, index: true, foreign_key: true
      t.references :users_protocol, index: true, foreign_key: true
      t.boolean :included
    end
  end
end
