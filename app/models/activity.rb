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

class Activity < ApplicationRecord
	before_save :set_created_year




protected

	def set_created_year
		self.created_year = created_at.year
	end



end