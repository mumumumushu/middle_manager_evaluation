# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
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
#  job_num                :string
#  user_info              :text
#

FactoryGirl.define do
  factory :leader, class: Leader do
    job_num 'leader_job_num'
    password 'hahaha'
    authentication_token 'qwertyuiop1'
    user_info 'leader_user_info'

		after(:create) do |leader|
			create( :evaluation, evaluationable: leader)
		end
  end

  factory :staff, class: Staff do
  	job_num 'staff_job_num'
    password 'hahaha'
    authentication_token 'qwertyuiop1'
    user_info 'staff_user_info'

    after(:create) do |staff|
			create( :evaluation, evaluationable: staff)
		end
    
  end

  factory :middle_manager, class: MiddleManager do
  	job_num 'middle_manager_job_num'
    password 'hahaha'
    authentication_token 'qwertyuiop1'
    user_info 'middle_manager_user_info'

    after(:create) do |middle_manager|
			create( :evaluation, evaluationable: middle_manager)
		end
    
  end
end
