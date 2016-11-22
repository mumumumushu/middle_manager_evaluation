# == Schema Information
#
# Table name: activities
#
#  id                    :integer          not null, primary key
#  first_phase_begin     :datetime
#  second_phase_begin    :datetime
#  third_phase_begin     :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  activity_year :integer
#  third_phase_end       :datetime
#  first_phase_end       :datetime
#  second_phase_end      :datetime
#  activity_year         :string
#

FactoryGirl.define do
  factory :activity do
  	activity_year "2016"
    first_phase_begin "2016-10-1 00:00:00"
    first_phase_end "2016-10-30 00:00:00"
    second_phase_begin "2016-11-1 00:00:00"
    second_phase_end "2016-11-30 00:00:00"
    third_phase_begin "2016-12-1 00:00:00"
    third_phase_end "2016-12-30 00:00:00"
  end
end
