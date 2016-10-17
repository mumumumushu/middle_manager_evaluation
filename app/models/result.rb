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

	def for_whom
		SelfEvaluation.find( self_evaluation_id )
	end

	def middle_manager_id
		self.for_whom.user_id
	end

	def evaluations
		self.for_whom.evaluations
	end

	#各等级 数量 的数组
  def each_level_count_array
  	_sum_array = []

  	1.upto(4) do |n|
  		_sum = 0
  		_one_level_sum = self.evaluations.each{ |x| _sum += x.level_count[n] } 
  		_sum_array += [ _one_level_sum ]
  	end	

  	_sum_array 	
  end

	#小项总票数
  def sum_of_level_count
  	self.each_level_count_array.inject(0){|sum,x| sum + x }
  end

  #中层干部整体评价 各等级评价的 票数 与 比例
  def level_count_and_bili
		_name_keys = [ '好-票数', '好-比例', '较好-票数', '较好-比例', '一般-票数', '一般-比例', '较差-票数', '较差-比例' ]
		#百分比显示方法！！！

		_count_and_bili = []
		1.upto(4) do |n|
			_count_and_bili += [ self.each_level_count_array[n], self.each_level_count_array[n] / self.sum_of_level_count ] 
		end

		[ _name_keys , _count_and_bili ].to_h
	end

	def each_result_level_count_array
		_level_count_array = [0,0,0,0]

		self.evaluations.each do |e|
			case e.average_score_level
				when "优秀"
					_level_count_array[1] += 1
				when "称职"
					_level_count_array[2] += 1
				when "基本称职"
					_level_count_array[3] += 1
				when "不称职"
					_level_count_array[4] += 1
				else	
			end
		end

		_level_count_array			
	end

	def sum_of_result_level_count
		self.each_result_level_count_array.inject(0){|sum,x| sum + x }
	end


	def result_level_count
		_name_keys = [ '优秀-票数', '优秀-比例', '称职-票数', '称职-比例', '基本称职-票数', '基本称职-比例', '不称职-票数', '不称职-比例' ]
		#百分比显示方法！！！

		_count_and_bili = []
		1.upto(4) do |n|
			_count_and_bili += [ self.each_result_level_count_array[n], self.each_result_level_count_array[n] / self.sum_of_result_level_count ] 
		end

		[ _name_keys , _count_and_bili ].to_h
	end

	

	# def level_1_count_sum
	# 	_sum = 0
	# 	self.evaluations.each{ |x| _sum += x.level_count[1] } 	
	# end

	# def level_2_count_sum
	# 	_sum = 0
	# 	self.evaluations.each{ |x| _sum += x.level_count[2] } 	
	# end
	
	# def level_3_count_sum
	# 	_sum = 0
	# 	self.evaluations.each{ |x| _sum += x.level_count[3] } 	
	# end

	# def level_4_count_sum
	# 	_sum = 0
	# 	self.evaluations.each{ |x| _sum += x.level_count[1] } 	
	# end

	# def level_count_sum
	# 	self.level_1_count_sum + self.level_2_count_sum + self.level_3_count_sum + self.level_4_count_sum
	# end

	





end
