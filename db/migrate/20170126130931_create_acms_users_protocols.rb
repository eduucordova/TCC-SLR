class CreateAcmsUsersProtocols < ActiveRecord::Migration
  def change
    create_table :acms_users_protocols do |t|
      t.references :acm, index: true, foreign_key: true
      t.references :users_protocol, index: true, foreign_key: true
      t.boolean :included
    end
  end
end
