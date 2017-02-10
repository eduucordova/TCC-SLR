class CreateSpringersUsersProtocols < ActiveRecord::Migration
  def change
    create_table :springers_users_protocols do |t|
      t.references :springer, index: true, foreign_key: true
      t.references :users_protocol, index: true, foreign_key: true
      t.boolean :included
    end
  end
end
