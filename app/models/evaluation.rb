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

  
  belongs_to :evaluationable, polymorphic: true

  before_validation :in_first_or_second_phase?
 	validates :in_first_or_second_phase?, presence: true, message: '填写未开放'




  protected


  def in_first_or_second_phase?
  	_activity = Activity.where(:activity_create_year => Time.now.year )
    _activity.first_phase_begin  < Time.now && Time.now < _activity.third_phase_begin
  end

  

end
