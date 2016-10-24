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
#  activity_id            :integer
#  take_part_in           :boolean
#  user_type              :string
#

 # aliases: [:author, :commenter]

FactoryGirl.define do
  factory :leader do
    job_num 'leader_job_num'
    password 'hahaha'
    authentication_token 'l_qwertyuiop1'  #不可重复
    user_type 'leader'
    take_part_in true
    
  end

  factory :staff  do
  	job_num 'staff_job_num'
    password 'hahaha'
    authentication_token 's_qwertyuiop1'
    user_type 'staff'
    take_part_in true
  end

  factory :middle_manager do
  	job_num 'middle_manager_job_num'
    password 'hahaha'
    authentication_token 'm_qwertyuiop1'
    user_type 'middle_manager'
    take_part_in true
  end

  # factory :other_middle_manager, class: :middle_manager do
  #   sequence(:job_num, 1000) {|n| "#{n}"}
  #   sequence(:authentication_token) {|n| "qwertyuiop#{n}"}
  #   password 'hahaha'
  #   user_type 'middle_manager'
  #   take_part_in true
  # end

  factory :middle_manager2, class: :middle_manager do
    job_num 'middle_manager_job_num12'
    password 'hahaha'
    authentication_token 'm_qwertyuiop12'
    user_type 'middle_manager'
    take_part_in true
  end

  factory :wrong_type, class: :user do
    job_num 'staff_job_num'
    password 'hahaha'
    authentication_token 'wertyuiop1'
    user_type 'wrong_type'
    take_part_in true
  end


end
    # after(:create) do |middle|
    #    @activity = create(:activity)
    #   @self_evaluation = create(:self_evaluation, 
    #                               middle_manager: @middle_manager,
    #                               activity: @activity)

    #   # @evaluations = create_list(:evaluation, 10,
    #   #                               self_evaluation: @self_evaluation,
    #   #                               user: @middle_manager)
    # end

    # association :m_evaluation, factory: :evaluation#, evaluationable_type: "middle_manager"
    #cloud_closet_api --image

    #多态对象创建
    # after(:create) do |middle_manager|
		# 	create( :evaluation, evaluationable: middle_manager)
		# end
    
