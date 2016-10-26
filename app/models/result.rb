# == Schema Information
#
# Table name: results
#
#  id                 :integer          not null, primary key
#  self_evaluation_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  final_result       :string
#

class Result < ApplicationRecord
  belongs_to :self_evaluation

	def user_id
		self.self_evaluation.middle_manager_id
	end

	def evaluations		
		Evaluation.where( :self_evaluation_id => self.self_evaluation_id )
	end

#############中层干部整体评价##############

	#小项 各等级 数量 的数组
  def each_level_count_array
  	_sum_array = []

  	0.upto(3) do |n|
  		_sum = 0
  		self.evaluations.each{ |x| _sum += x.level_count[n] } 
  		_sum_array += [ _sum ]
  	end	

  	_sum_array 	
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
			_percentage = self.sum_of_level_count == 0 ? -1 :((self.each_level_count_array[n]).to_f/(self.sum_of_level_count).to_f * 100).round(2) || 0
			_count_and_percentage += [ self.each_level_count_array[n], '%.2f' % _percentage + '%'] 
		end

		_x = []
		0.upto(7) do |n|
			_x += [ Hash[ _name_keys[n], _count_and_percentage[n] ] ]
		end	
		_x
	
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
			_percentage = self.sum_of_level_count == 0 ? -1 : ((self.each_result_level_count_array[n]).to_f/(self.sum_of_result_level_count).to_f * 100).round(2) 
			_count_and_percentage += [ self.each_result_level_count_array[n], '%.2f' % _percentage + '%'] 
		end

		_x = []
		0.upto(7) do |n|
			_x += [ Hash[ _name_keys[n], _count_and_percentage[n] ] ]
		end	
		_x
	end

#############自评数据##############

	def self_evaluation_duties #（✔️）
		self.self_evaluation.duties
	end

	def self_evaluation_totality # 自我总体评价（✔️）
		self.self_evaluation.self_evaluation_totality
	end

	def name #（✔️）
		User.find( self.user_id ).user_info.name
	end

	def department_and_duty #职务 #（✔️）
		User.find( self.user_id ).user_info.department_and_duty
	end

	def evaluated_user_info
		self.self_evaluation.evaluated_user_info
	end




###########  各角色总平均分  #########
###待测试
	def average_score_for_role role
		_arry = Evaluation.where( " self_evaluation_id = ? AND evaluating_user_type = ?", self.self_evaluation_id, role)
		_sum = 0.00
		_arry.each { |evaluation| _sum += evaluation.average_score }
 	  
 	  _arry.count == 0 ? -1 : ( _sum.to_f / _arry.count.to_f ).round(2)	
	end

	def average_score_for_staff
		self.average_score_for_role('staff')
	end

	def average_score_for_middle_manager
		self.average_score_for_role('middle_manager')
	end

	def average_score_for_leader
		self.average_score_for_role('leader')
	end

########  考核总分 及 考核等级  ##########

	def average_score_for_all
		self.average_score_for_leader * 0.5 +
		self.average_score_for_middle_manager * 0.3 +
		self.average_score_for_staff * 0.2
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
		User.where( "take_part_in = ? AND user_type = ?", true, 'middle_manager' ).count
	end
	
	def count_of_all_user
		User.where( :take_part_in => true ).count
	end	

end
	
	


