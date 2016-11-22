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

class Activity < ApplicationRecord
	# before_save :set_created_year
	has_many :self_evaluations, dependent: :destroy 

	validate :has_user_list?

	after_create :create_self_evaluation, on: [:create, :update]
	
	def has_user_list?
		unless User.where(take_part_in: "#{self.activity_year}").any?
			errors.add(:take_part_in, "please make sure that you have upload the user_list for this activity")
		end
	end

	def activity_year_of_activities_have_user_list
		User.all.collect(&:take_part_in).uniq.reject{|x| x == nil}[0]
	end

private

	# def set_created_year
	# 	self.activity_year = self.first_phase_begin.year
	# end

	def create_self_evaluation  
		MiddleManager.where(take_part_in: self.activity_year, user_type: 'middle_manager').each do |middle_manager|
			_self_evaluation = SelfEvaluation.new(activity_id: self.id,
																						middle_manager_id: middle_manager.id,
																						duties: '',
																						self_evaluation_totality: "")
			unless _self_evaluation.save
				logger.error '自评表创建失败'
			end
		end
	end

end
