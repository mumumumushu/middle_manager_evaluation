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
#  activity_created_year :integer
#

FactoryGirl.define do
  factory :activity do
    first_phase_begin "2016-10-11 15:29:57"
    second_phase_begin "2016-10-11 15:29:57"
    third_phase_begin "2016-10-11 15:29:57"
  end
end
