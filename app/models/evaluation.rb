# == Schema Information
#
# Table name: evaluations
#
#  id                     :integer          not null, primary key
#  thought_morals         :text
#  upright_incorruptiable :text
#  duties                 :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  evaluation_totality    :integer
#  evaluationable_type    :string
#  evaluationable_id      :integer
#  create_year            :string
#  self_evaluation_id     :integer
#

class Evaluation < ApplicationRecord

  
  belongs_to :user #:evaluationable, polymorphic: true
  belongs_to :self_evaluation
	before_validation :in_first_or_second_phase?
 ##	
 	validates_presence_of :in_first_or_second_phase?, :message => '填写未开放'
 ##	
 	validates_presence_of	:thought_morals
 	validates_presence_of	:upright_incorruptiable
 	# :duties  ####!score
 	validates_presence_of :duties
 	validates_presence_of :evaluation_totality
##
	def created_year
    SelfEvaluation.find( self.self_evaluation_id ).created_year 
  end



  private	


  def in_first_or_second_phase?
  	_activity = Activity.find( SelfEvaluation.find( self.self_evaluation_id ).activity_id )
    
    _activity.first_phase_begin  < Time.now && Time.now < _activity.third_phase_begin
  
  end



end
