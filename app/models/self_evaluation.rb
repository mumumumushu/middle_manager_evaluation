# == Schema Information
#
# Table name: self_evaluations
#
#  id                       :integer          not null, primary key
#  duties                   :string
#  self_evaluation_totality :string
#  middle_manager_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_year             :integer
#

class SelfEvaluation < ApplicationRecord
  belongs_to :middle_manager
  has_many :evaluations, as: :evaluationable


  before_save :in_first_phase?
  



  

 









  

  protected

  def in_first_phase?

    _activity = Activity.where(:activity_create_year => Time.now.year )

    _activity.first_phase_begin  < Time.now && Time.now < _activity.second_phase_begin

  end
 	
  




end
