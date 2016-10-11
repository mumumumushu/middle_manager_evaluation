class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          authentication_keys: [:job_num]








   protected
  def email_required?
    false
  end

  def job_num_required?
    true
  end

  def email_changed?
    false
  end
  
end
