# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  job_num                :string           default(""), not null
#  authentication_token   :string(30)
#  take_part_in           :boolean          default(FALSE)
#  user_type              :string
#

class User < ApplicationRecord
  
  ## Token Authenticatable
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          authentication_keys: [:job_num]

  validates :job_num, uniqueness: true
  #has_many :evaluations, as: :evaluationable
  has_many :evaluations
  has_one :user_info

  def right_type? type
    self.user_type == type and self.take_part_in
  end

  def info
    self.user_info || self.create_user_info
  end
 
  def email_required?
    false
  end

  def email_changed? #删除email字段后 需要加上
    false
  end

  # def job_num_required?
  #   true    
  # end
  
end
