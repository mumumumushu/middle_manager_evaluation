# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  user_type              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  evaluation_totality    :integer
#  evaluationable_type    :string		父亲的类别
#  evaluationable_id      :integer  该类别的父亲的id
#  create_year            :string
#

class Evaluation < ApplicationRecord

  
  belongs_to :evaluationable, polymorphic: true

  before_validation :can_edit?




  protected

  def in_second_phase?
    _activity = Activity.where(:activity_create_year => Time.now.year )
    _activity.second_phase_begin  < Time.now && Time.now < _activity.third_phase_begin
  end

  def in_first_phase?
    _activity = Activity.where(:activity_create_year => Time.now.year )
    _activity.first_phase_begin  < Time.now && Time.now < _activity.second_phase_begin
  end



  def can_edit?
  	if self.evaluationable_type == 'self_evaluation'
  		self.in_first_phase?
		else
			self.in_second_phase?
  	end	
  	
  end

end
