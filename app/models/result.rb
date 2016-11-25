# == Schema Information
#
# Table name: results
#
#  id                    :integer          not null, primary key
#  self_evaluation_id    :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  final_result          :string
#  activity_year         :string
#  final_evaluation_time :datetime
#

class Result < ApplicationRecord
  belongs_to :self_evaluation

  before_save :set_activity_year

  scope :activity_year, -> (year){where(activity_year: year)}

	def evaluations		
		Evaluation.where( self_evaluation_id: self.self_evaluation_id )
	end

#############中层干部整体评价##############

	#所有小项 各等级 总数量 的数组
  def each_level_count_array
  	0.upto(3).map do |n|
  		_sum = 0
  		self.evaluations.each{ |x| _sum += x.level_count[n] } 
  		_sum
  	end	
  end

	#小项总票数 #（✔️）
  def sum_of_level_count
  	self.each_level_count_array.inject(0){|sum,x| sum + x }
  end

  #中层干部整体评价 各等级评价的 票数 与 比例 #（✔️）
  def level_count_and_percentage		
		_name_keys = [ 'excellent-count', 'excellent-proportion', 'good-count', 'good-proportion','average-count','average-proportion', 'bad-count','bad-proportion']

		_count_and_percentage = []
		0.upto(3) do |n|
			_percentage = self.sum_of_level_count == 0 ? 0 :((self.each_level_count_array[n]).to_f/(self.sum_of_level_count).to_f * 100).round(2) || 0
			_count_and_percentage += [ self.each_level_count_array[n], '%.2f' % _percentage + '%'] 
		end
		_hash = {}
		0.upto(7).each do |n|
			_hash[_name_keys[n]] = _count_and_percentage[n]
		end	
		_hash
	end

#############个人考核测评结果##############

	#个人考核结果  各等级 数量 的数组
	def each_result_level_count_array
		_level_count_array = [0,0,0,0]

		self.evaluations.each do |e|
			case e.average_score_level
				when "优秀"
					_level_count_array[0] += 1
				when "称职"
					_level_count_array[1] += 1
				when "基本称职"
					_level_count_array[2] += 1
				when "不称职"
					_level_count_array[3] += 1
			end
		end

		_level_count_array			
	end

	def sum_of_result_level_count #（✔️）
		self.each_result_level_count_array.inject(0){|sum,x| sum + x }
	end


	def result_level_count_and_percentage #（✔️）
		 _name_keys = [ 'excellent-count', 'excellent-proportion', 'good-count', 'good-proportion', 'average-count', 'average-proportion', 'bad-count', 'bad-proportion' ]

		_count_and_percentage = []
		0.upto(3) do |n|
			_percentage = self.sum_of_level_count == 0 ? 0 : ((self.each_result_level_count_array[n]).to_f/(self.sum_of_result_level_count).to_f * 100).round(2) 
			_count_and_percentage += [ self.each_result_level_count_array[n], '%.2f' % _percentage + '%'] 
		end
		_hash = {}
		0.upto(7).each do |n|
			_hash[_name_keys[n]] =  _count_and_percentage[n]
		end	
		_hash		
	end

#############自评数据##############

	def self_evaluation_duties #（✔️）
		self.self_evaluation.duties_output
	end

	def self_evaluation_totality # 自我总体评价（✔️）
		self.self_evaluation.self_evaluation_totality
	end

	def name #（✔️）
		self.self_evaluation.name
	end

	def department_and_duty #职务 #（✔️）
		self.self_evaluation.department_and_duty
	end

	def evaluated_user_info
		self.self_evaluation.evaluated_user_info
	end




###########  各角色总平均分  #########
###待测试
	def average_score_for_role role
		_evaluations = Evaluation.where( "self_evaluation_id = ? AND evaluating_user_type = ?", self.self_evaluation_id, role)
		_array = _evaluations.collect(&:average_score).reject{|x| x == 0 }
		_sum = 0.00
		_array.each { |e| _sum += e }
 	  _array.count == 0 ? nil : ( _sum.to_f / _array.count.to_f ).round(2)	
	end

	def average_score_for_staff
		self.average_score_for_role('职工')
	end

	def average_score_for_middle_manager
		self.average_score_for_role('中层干部')
	end

	def average_score_for_leader
		self.average_score_for_role('领导')
	end

########  考核总分 及 考核等级  ##########

	def average_score_for_all
		s = (self.average_score_for_leader || 0 ) * 0.5 +
		(self.average_score_for_middle_manager || 0 )* 0.3 +
		(self.average_score_for_staff || 0 )* 0.2
		s.round(2)
	end

	def level_of_average_score_for_all
		_x = average_score_for_all
		case 
      when _x >= 90 && _x <= 99
        "优秀"
      when _x < 90 && _x >= 80
        "称职"
      when _x < 80 && _x >= 60
        "基本称职"
      when _x < 60 && _x >= 0
        "不称职"
      else
      	""
    end
	end

#############参与人数##############

	def count_of_middle_manager
		User.where( "take_part_in = ? AND user_type = ?", self.activity_year, 'middle_manager' ).count
	end
	
	def count_of_all_user
		User.where(take_part_in: self.activity_year).count
	end	

	##########

	def self.change_score_array_to_level_data array
		array = array.map { |e| e == nil ? -1 : e }
    _level_count_array = [ 
      array.select{ |x| x <= 99 && x >= 90 }.count,
      array.select{ |x| x <= 89 && x >= 80 }.count,
      array.select{ |x| x <= 79 && x >= 60 }.count,       
      array.select{ |x| x <= 59 && x >= 0}.count 
    ] 

    _sum_count = 0 
    _level_count_array.each {|x| _sum_count += x}

    _name_keys = [ 'excellent-count', 'excellent-proportion', 'good-count', 'good-proportion', 'average-count', 'average-proportion', 'bad-count', 'bad-proportion' ]

		_count_and_percentage = []

		0.upto(3) do |n|
			_percentage = _sum_count == 0 ? -1 : ((_level_count_array[n]).to_f/(_sum_count).to_f ).round(2) * 100
			_count_and_percentage += [ _level_count_array[n], '%.2f' % _percentage + '%'] 
		end
		_hash = {}
		0.upto(7).each do |n|
			_hash[_name_keys[n]] = _count_and_percentage[n]
		end	
		_hash
  end

  private

  def set_activity_year
  	self.activity_year = self.self_evaluation.activity.activity_year
  end

end
	
	


