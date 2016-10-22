# == Schema Information
#
# Table name: user_infos
#
#  id                                :integer          not null, primary key
#  name                              :string
#  user_id                           :integer
#  sex                               :string
#  date_of_birth                     :string
#  politics_status                   :string
#  degree_of_education               :string
#  department_and_duty               :string
#  job                               :string
#  starting_time_for_the_present_job :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  user_type                         :string
#

FactoryGirl.define do
  factory :user_info do
    name "谌明举"
    sex "男"
    date_of_birth "1981.10"
    politics_status "中共党员"
    degree_of_education "中共党员"
    department_and_duty "计算机应用系 党支部书记、副主任"
    job "基层党建工作、学生教育与管理"
    starting_time_for_the_present_job "2015.4"
  end
end
