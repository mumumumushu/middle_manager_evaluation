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

class Staff < User
	
	validates :job_num, :password, presence: true
	# has_many :evaluations, ->{ where evaluationable_type: 'staff' },as: :evaluationable
	
end
