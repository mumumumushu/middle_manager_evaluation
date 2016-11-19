# == Schema Information
#
# Table name: self_evaluations
#
#  id                       :integer          not null, primary key
#  duties                   :string
#  self_evaluation_totality :string
#  middle_manager_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_year             :integer
#  activity_id              :integer
#  user_info                :string
#  evaluated_user_info      :text
#

#

FactoryGirl.define do
  factory :self_evaluation do
    duties '项目1,80;项目2,70;项目3,60;项目4,90'
    self_evaluation_totality "优秀"
    #middle_manager nil
    #acticity nil
    created_at '2016-10-2 15:29:57'
  end
end
