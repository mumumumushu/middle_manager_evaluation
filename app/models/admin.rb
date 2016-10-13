class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #authentication_keys: [:phone]


  acts_as_token_authenticatable




  # protected
  # def email_required?
  #   false
  # end

  # def phone_required?
  #   true
  # end

  # def email_changed?
  #   false
  # end

end
