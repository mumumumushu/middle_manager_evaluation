# == Schema Information
#s
# Table name: results
#
#  id                 :integer          not null, primary key
#  self_evaluation_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  final_result       :string
#

FactoryGirl.define do
  factory :result do
  	final_result "未评鉴"
    #self_evaluation nil   
  end


 #  factory :result_detail, class: :result do
	# 	self_evaluation_duties '{"项目1":80,"项目2":70,"项目3":60,"项目4":90}'
	# 	name '谌明举'
	# 	department_and_duty '计算机应用系 党支部书记、副主任'
	# 	sum_of_level_count 20
	# 	level_count_and_percentage '{"好-票数":6,"好-比例":"30.00%","较好-票数":4,"较好-比例":"20.00%","一般-票数":8,"一般-比例":"40.00%","较差-票数":2,"较差-比例":"10.00%"}'
	# 	sum_of_result_level_count 2
	# 	result_level_count_and_percentage '{"优秀-票数":0,"优秀-比例":"0.00%","称职-票数":0,"称职-比例":"0.00%","基本称职-票数":2,"基本称职-比例":"100.00%","不称职-票数":0,"不称职-比例":"0.00%"}'
	# end
end