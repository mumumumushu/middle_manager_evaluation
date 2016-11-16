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
#  third_phase_end       :datetime
#  first_phase_end       :datetime
#  second_phase_end      :datetime
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
	it { should have_many(:self_evaluations)}
end
