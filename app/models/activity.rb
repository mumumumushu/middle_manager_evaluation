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
	has_many :self_evaluations

	after_create :create_self_evaluation
	




private

	def set_created_year
		self.activity_created_year = self.first_phase_begin.year
	end

	def create_self_evaluation
		MiddleManager.where("take_part_in = ?", true).each do |middle_manager|
			_self_evaluation = SelfEvaluation.new
			_self_evaluation.activity_id = self.id
			_self_evaluation.middle_manager_id = middle_manager.id
			_self_evaluation.duties = '{}'
			_self_evaluation.self_evaluation_totality = ""
			_self_evaluation.save
		end
	end

	

end
