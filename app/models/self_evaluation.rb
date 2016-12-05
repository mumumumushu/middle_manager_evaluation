# == Schema Information
#
# Table name: self_evaluations
#
#  id                       :integer          not null, primary key
#  duties                   :text
#  self_evaluation_totality :string
#  middle_manager_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_year             :integer
#  activity_id              :integer
#  user_info                :string
#  evaluated_user_info      :text
#  user_info_id             :integer
#  activity_year            :string
#  department_and_duty      :string
#  job                      :string
#

class SelfEvaluation < ApplicationRecord
  belongs_to :middle_manager
  belongs_to :activity
  has_many :evaluations, dependent: :destroy
  has_one :result

  before_save :set_activity_year
  before_save :backup_some_params_from_user_info
  # before_save :set_user_info_id

  # before_validation :in_first_phase?
  # validates_presence_of :in_first_phase?, :message => '填写未开放'
  # validates_presence_of :duties
  # validates_presence_of :self_evaluation_totality
  
  # before_create :set_evaluated_user_info
  after_save :create_evaluations
  # after_update :update_evaluations
  after_create :create_result

  scope :activity_year, -> (activity_year) {where(activity_year: activity_year)}
  ##??? middle_manager_id == user_id  ✔️
  
  def already_edited
    self.self_evaluation_totality == "" ? false : true
  end

  def name
    self.middle_manager.user_info.name
  end

  # def department_and_duty #职务
  #   self.middle_manager.user_info.department_and_duty
  # end

  def duties_output 
    self.duties ? self.duties.split(";").map { |e| e.split(",") } : []
  end
  
  # def change_output_format field
  #   self.send(field) ? self.send(field).split(";").map { |e| e.split(",") } : []
  # end

  private

  def set_activity_year
    self.activity_year = self.activity.activity_year 
  end

  # def set_user_info_id 
  #   self.user_info_id = self.middle_manager.user_info.id  
  # end

  def backup_some_params_from_user_info
    self.job = self.middle_manager.user_info.job
    self.department_and_duty = self.middle_manager.user_info.department_and_duty
  end

 	def create_evaluations
    User.where(take_part_in: self.activity_year).each do |user|
      unless user.id == self.middle_manager_id
        _evaluation = user.evaluations.where( :self_evaluation_id => self.id).first || Evaluation.new
        _evaluation.self_evaluation_id = self.id
        _evaluation.user_id = user.id

        ##打分表初始分数 --> -1
        _duties = self.duties_output.map { |e| "#{e[0]},-1" }.join(";")

        _evaluation.duties = _duties
        _evaluation.thought_morals = '思想政治态度,-1;道德作风品行,-1;团结协调合作,-1'
        _evaluation.upright_incorruptiable = '廉洁从政,-1;执行党风廉政建设责任制,-1'
        _evaluation.evaluation_totality = -1
        _evaluation.save
      end
    end
  end

  def create_result
    _result = Result.new(:self_evaluation_id => self.id,
                         :final_result => "未评鉴")
    _result.save
  end

end
