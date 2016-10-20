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

  def name
    SelfEvaluation.find(self.self_evaluation_id).name
  end

  def evaluated_user_info
    SelfEvaluation.find(self.self_evaluation_id).evaluated_user_info
  end

  def department_and_duty #职务
    SelfEvaluation.find(self.self_evaluation_id).department_and_duty
  end

  #统计
  #分数集合  剔除 -1（空）
  def score_array
    _score = MultiJson.load(self.thought_morals).values.reject{ |x| x == -1} +
              MultiJson.load(self.upright_incorruptiable).values.reject{ |x| x == -1} + 
              MultiJson.load(self.duties).values.reject{ |x| x == -1} +
              [evaluation_totality]
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
    _average_score = _sum / _score.count
    #四舍五入？？？？？？
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
      else
        "不称职"
    end  

  end




  private	


  def in_first_or_second_phase?
  	_activity = Activity.find( SelfEvaluation.find( self.self_evaluation_id ).activity_id )
    
    _activity.first_phase_begin  < Time.now && Time.now < _activity.third_phase_begin
  
  end



end
