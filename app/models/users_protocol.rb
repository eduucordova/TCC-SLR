class UsersProtocol < ActiveRecord::Base
    belongs_to :user
    belongs_to :protocol
    belongs_to :role
end