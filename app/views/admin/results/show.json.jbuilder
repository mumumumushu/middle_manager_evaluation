json.name @result.name




	json.leader_evaluations @leader_evaluations, :add_index
	json.middle_manager_evaluations @middle_manager_evaluations, :add_index
	json.staff_evaluations @staff_evaluations, :add_index
 


_all_array = []

@evaluations.each do |evaluation|
	_all_array += [evaluation.score_array_filled]
end


json.statistics do
	json.array! 0.upto(_all_array[0].count-1) do |i|
	
		_statistics = _all_array[1][i] == -1 ? {} : Result.change_socre_array_to_level_data(_all_array.map { |a| a[i]})

		json.set! i, _statistics
			
	end
end
