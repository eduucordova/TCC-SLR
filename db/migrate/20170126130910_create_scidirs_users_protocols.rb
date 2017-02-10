class CreateScidirsUsersProtocols < ActiveRecord::Migration
  def change
    create_table :scidirs_users_protocols do |t|
      t.references :scidir, index: true, foreign_key: true
      t.references :users_protocol, index: true, foreign_key: true
      t.boolean :included
    end
  end
end
