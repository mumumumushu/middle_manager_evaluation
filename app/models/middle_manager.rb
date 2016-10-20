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
#  user_type              :string
#  activity_id            :integer
#  take_part_in           :boolean          default(TRUE)
#

class MiddleManager < User

	validates :job_num, :password, presence: true
	
	has_one :self_evaluation

	def middle_manager_id
	 ##??需要 ？??? self_evaluation 有middle_manager_id
		self.id
	end

	def evaluationed_by_others
		self_evaluation.evaluations
	end

	# def email_required?
	#   false
	# end
	

	
end

