class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 4..40

  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable, password_length: 4..40

  has_many :users_protocols, dependent: :destroy
  has_many :protocols, through: :users_protocols

  def ldap_before_save
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
  end

end
