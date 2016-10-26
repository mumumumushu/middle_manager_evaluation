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
#  user_info                :string
#  evaluated_user_info      :text
#

class SelfEvaluation < ApplicationRecord
  belongs_to :middle_manager
  belongs_to :activity
  has_many :evaluations
  has_one :result

  # before_validation :in_first_phase?
  # validates_presence_of :in_first_phase?, :message => '填写未开放'
  # validates_presence_of :duties
  # validates_presence_of :self_evaluation_totality
  
  # before_create :set_evaluated_user_info
  after_save :create_evaluations
  # after_update :update_evaluations
  after_create :create_result

  def created_year
    self.activity.activity_created_year 
  end
  ##??? middle_manager_id == user_id ??
  def name
    self.middle_manager.user_info.name
  end

  def department_and_duty #职务
    self.middle_manager.user_info.department_and_duty
  end

  private

  #  def set_evaluated_user_info
  #   _user_info_in_user = self.middle_manager.user_info
  #   _arry = [
  #                     "姓名", _user_info_in_user.name,
  #                     "性别", _user_info_in_user.sex,
  #                     "出生年月", _user_info_in_user.date_of_birth,
  #                     "政治面貌", _user_info_in_user.politics_status,
  #                     "文化程度", _user_info_in_user.degree_of_education,
  #                     "现任职时间", _user_info_in_user.starting_time_for_the_present_job,
  #                     "从事或分管工作", _user_info_in_user.department_and_duty,
  #                     "部门及职务", _user_info_in_user.job
  #                     ]
  #   self.evaluated_user_info = Hash[*_arry]
  # end

  # def in_first_phase?
  #   _activity = Activity.find( self.activity_id )
  #   _activity.first_phase_begin  < Time.now && Time.now < _activity.second_phase_begin  
  # end

 	def create_evaluations
    User.where(:take_part_in => true).each do |user|
      unless user.id == self.middle_manager_id
        _evaluation = user.evaluations.where( :self_evaluation_id => self.id).first || Evaluation.new
        _evaluation.self_evaluation_id = self.id
        _evaluation.user_id = user.id
        
        _duties = {}
        _keys = MultiJson.load(self.duties).keys
        0.upto( _keys.count - 1 ) do |n|
          _duties.store( _keys[n], -1 )
        end                        #####!!!!!#####
                                   ####打分表初始分数 --> -1
        _evaluation.duties = _duties
        _evaluation.save
      end
    end
  end

  # def update_evaluations
  #   User.where(:take_part_in => true).each do |user|
  #     unless user.id == self.middle_manager_id
  #       _evaluation = user.evaluations.where( :self_evaluation_id => self.id).first        
        
  #       _duties = {}
  #       _keys = MultiJson.load(self.duties).keys
  #       0.upto( _keys.count - 1 ) do |n|
  #         _duties.store( _keys[n], -1 )
  #       end                        #####!!!!!#####
  #                                  ####打分表初始分数--> -1
  #       _evaluation.duties = _duties

  #       _evaluation.save
  #     end
  #   end 
  # end

  def create_result
    _result = Result.new(:self_evaluation_id => self.id,
                         :final_result => "未评鉴")
    _result.save
  end

end
