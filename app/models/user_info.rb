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
#  job_num                           :string
#

class UserInfo < ApplicationRecord
  belongs_to :user

  before_create :set_job_num

  private

  def set_job_num
  	self.job_num = self.user.job_num
  end
end
