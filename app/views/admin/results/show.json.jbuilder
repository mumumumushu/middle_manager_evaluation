_all_array = []

json.table do

	i = 0
	@leader_evaluations.each do |evaluation|
		i += 1
		json.set!  "#{evaluation.evaluating_user_type}_#{i}", evaluation.score_array_filled

		_all_array += [evaluation.score_array_filled]
	end

	i = 0
	@middle_manager_evaluations.each do |evaluation|
		i += 1
		json.set!  "#{evaluation.evaluating_user_type}_#{i}", evaluation.score_array_filled

		_all_array += [evaluation.score_array_filled]
	end

	i = 0
	@staff_evaluations.each do |evaluation|
		i += 1
		json.set!  "#{evaluation.evaluating_user_type}_#{i}", evaluation.score_array_filled

		_all_array += [evaluation.score_array_filled]
	end
 
end

json.statistics do
	json.array! 0.upto(_all_array[0].count-1) do |i|
	
		_statistics = _all_array[1][i] == -1 ? {} : Result.change_socre_array_to_level_data(_all_array.map { |a| a[i]})

		json.array!  _statistics
			
	end
end
