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
#  self_evaluation_id     :integer
#  user_id                :integer
#  already_edited         :boolean          default(FALSE)
#  evaluating_user_type   :string
#  activity_id            :integer
#

class Evaluation < ApplicationRecord
  
  belongs_to :user #:evaluationable, polymorphic: true
  belongs_to :self_evaluation
	# before_validation :in_first_or_second_phase?

  before_create :set_evaluating_user_type
  before_create :set_activity_id
 ##	
 	# validates_presence_of :in_first_or_second_phase?, :message => '填写未开放'
 # ##	
 # 	validates_presence_of	:thought_morals
 # 	validates_presence_of	:upright_incorruptiable
 # 	# :duties  ####!score
 # 	validates_presence_of :duties
 # 	validates_presence_of :evaluation_totality
##
  scope :evaluated_by, -> (type) {where(evaluating_user_type: type)}
  scope :activity_id_is, -> (id) {where(activity_id: id)}
  scope :edited, -> {where(already_edited: true)}
  scope :unedited, -> {where(already_edited: false)}
##
	def created_year
    self.self_evaluation.created_year 
  end

  def name
    self.self_evaluation.name
  end

  def job_num
    self.self_evaluation.middle_manager.job_num
  end

  # def evaluated_user_info
  #   self.self_evaluation.evaluated_user_info
  # end

  def department_and_duty #职务
    self.self_evaluation.department_and_duty
  end

  #转换 duties, thought_morals, upright_incorruptiable
  def change_output_format field
    self.send(field) ? self.send(field).split(";").map { |e| e.split(",") } : []
  end

  #统计
  #分数集合  剔除 -1（空）
  def score_array
    _score = self.change_output_format("thought_morals").map { |e| e[1].to_i } +
             self.change_output_format("duties").map { |e| e[1].to_i } +
             self.change_output_format("upright_incorruptiable").map { |e| e[1].to_i } +
             [self.evaluation_totality]
    _score.reject{ |x| x == -1 }
  end
  #为 视图组织数据结构
  #分数集合 未填写的duties项 填充 nil
  #考核表选项 结构改变 需要改变
  #固定项 可在 self_evaluation.rb 中 改变初始值
  def score_array_filled
    _score = self.change_output_format("thought_morals").map { |e| e[1] == "-1" ? nil : e[1].to_i } +
             Array.new(3 - self.change_output_format("thought_morals").count, nil) +
             self.change_output_format("duties").map { |e| e[1] == "-1" ? nil : e[1].to_i } +
             Array.new(12 - self.change_output_format("duties").count, nil) +
             self.change_output_format("upright_incorruptiable").map { |e| e[1] == "-1" ? nil : e[1].to_i } +
             Array.new(2 - self.change_output_format("upright_incorruptiable").count, nil) +
             [self.evaluation_totality == -1 ? nil : self.evaluation_totality] +
             [self.average_score]

  end
  #分数集合 填充索引 转化数组每一项为键值对
  def add_index 
    _user_type = self.evaluating_user_type
    _score = self.score_array_filled
    _hash = {"姓名": _user_type}
    0.upto(_score.count - 1) do |i|
      _hash[i] =  _score[i] 
    end
    _hash
  end

  #好，较好，一般，较差
  def level_count
    [ 
      self.score_array.select{ |x| x <= 99 && x >= 90 }.count,
      self.score_array.select{ |x| x <= 89 && x >= 80 }.count,
      self.score_array.select{ |x| x <= 79 && x >= 60 }.count,       
      self.score_array.select{ |x| x <= 59 && x >= 0}.count
    ]       
  end

  #平均分 
  #优秀，称职，基本称职，不称职
  def average_score
    _score = self.score_array
    _sum = 0.00
    _score.each { |x| _sum += x} 
    _score.count == 0 ? 0 : (_average_score = _sum / _score.count).round(2)
  end

  def average_score_level
    _x = self.average_score
    case
      when _x >= 90 && _x <= 99
        "优秀"
      when _x < 90 && _x >= 80
        "称职"
      when _x < 80 && _x >= 60
        "基本称职"
      when _x < 60 && _x > 0 #将未填写的打分表（平均分0）剔除
        "不称职"
    end  
  end

  private	

  def set_evaluating_user_type
    self.evaluating_user_type = I18n.t :"user_type.#{self.user.user_type}"
  end

  def set_activity_id
    self.activity_id = self.self_evaluation.activity_id
  end

  # def in_first_or_second_phase?
  # 	_activity = Activity.find( SelfEvaluation.find( self.self_evaluation_id ).activity_id )  
  #   _activity.first_phase_begin  < Time.now && Time.now < _activity.third_phase_begin
  # end
end
