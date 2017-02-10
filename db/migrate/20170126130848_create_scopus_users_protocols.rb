class CreateScopusUsersProtocols < ActiveRecord::Migration
  def change
    create_table :scopus_users_protocols do |t|
      t.references :scopu, index: true, foreign_key: true
      t.references :users_protocol, index: true, foreign_key: true
      t.boolean :included
    end
  end
end
