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
#  activity_id              :integer
#  activity                 :reference
#

class SelfEvaluation < ApplicationRecord
  belongs_to :middle_manager
  belongs_to :activity
  has_many :evaluations
  has_one :result

  before_validation :in_first_phase?
  validates_presence_of :in_first_phase?, :message => '填写未开放'
  validates_presence_of :duties
  validates_presence_of :self_evaluation_totality

  after_create :create_evaluations
  after_update :update_evaluations

  def created_year
    Activity.all.find( activity_id ).activity_created_year 
  end
  


  private

  def in_first_phase?
    _activity = Activity.find( self.activity_id )

    _activity.first_phase_begin  < Time.now && Time.now < _activity.second_phase_begin
  
  end


 	def create_evaluations
    User.all.each do |user|
      unless user.id == middle_manager_id
        _evaluation = user.evaluations.new
        _evaluation.self_evaluations_id = self.id
        _evaluation.duties = self.duties
        #duties !!!!!

        _evaluation.save
      end
    end
  end

  def update_evaluations
    User.all.each do |user|
      unless user.id == middle_manager_id
        _evaluation = user.evaluations.where( :self_evaluations_id => self.id)   
        _evaluation.duties =  self.duties#.keys, [ Array.new ] ].to_hash 
 
        _evaluation.save
      end
    end 
  end



end
