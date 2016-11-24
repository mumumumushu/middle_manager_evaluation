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
		_one_item_score_array = _all_array.map { |a| a[i]}
		_statistics = _one_item_score_array.any? ? Result.change_socre_array_to_level_data(_one_item_score_array) : {} 

		json.set! i, _statistics
			
	end
end
