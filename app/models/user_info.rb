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
#

class UserInfo < ApplicationRecord
  belongs_to :user
end
