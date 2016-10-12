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
  has_many :evaluations


  before_validation :in_first_phase?
  validates :in_first_phase?, presence: true, message: '填写未开放'

  after_create :create_evaluations

  after_update :update_evaluations
  


  protected

  def in_first_phase?

    _activity = Activity.where(:activity_create_year => Time.now.year )

    _activity.first_phase_begin  < Time.now && Time.now < _activity.second_phase_begin

  end


 	def create_evaluations
    User.all.each do |user|
      _evaluation = user.evaluations.new
      _evaluation.self_evaluations_id = self.id
      _evaluation.duties = self.duties

      _evaluation.save

    end
  end

  def update_evaluations
    User.all.each do |user|

      _evaluation = user.evaluations.where( :self_evaluations_id => self.id)   
      _evaluation.duties = self.duties

      _evaluation.save

    end 
  end



end
