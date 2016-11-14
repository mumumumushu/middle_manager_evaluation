# class Array < BasicObject::Object

# 	def change_socre_array_to_level_data
#     _level_count_array = [ 
#       self.select{ |x| x <= 99 && x >= 90 }.count,
#       self.select{ |x| x <= 89 && x >= 80 }.count,
#       self.select{ |x| x <= 79 && x >= 60 }.count,       
#       self.select{ |x| x <= 59 && x >= 0}.count
#     ] 

#     _sum_count = self.inject(0){|sum,x| sum + x }

#     _name_keys = [ 'excellent-count', 'excellent-proportion', 'good-count', 'good-proportion', 'average-count', 'average-proportion', 'bad-count', 'bad-proportion' ]

# 		_count_and_percentage = []

# 		0.upto(3) do |n|
# 			_percentage = _sum_count == 0 ? -1 : ((_level_count_array[n]).to_f/(_sum_count).to_f * 100).round(2) 
# 			_count_and_percentage += [ _level_count_array[n], '%.2f' % _percentage + '%'] 
# 		end

# 		0.upto(7).map do |n|
# 			Hash[ _name_keys[n], _count_and_percentage[n]] 
# 		end	
#   end

# end