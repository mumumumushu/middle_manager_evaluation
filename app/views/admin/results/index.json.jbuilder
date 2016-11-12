
_leader_score_array = []
_middle_manager_score_array = []
_staff_score_array = []

json.table_1 do
	json.array! @results.each	do |result|
		json.(result, :name, :average_score_for_leader, :average_score_for_middle_manager, :average_score_for_staff, :average_score_for_all, :final_result)

		_leader_score_array += [result.average_score_for_leader]
		_middle_manager_score_array += [result.average_score_for_middle_manager]
		_staff_score_array += [result.average_score_for_staff]

	end
end

json.table_2 do

		json.leader @results.first.change_socre_array_to_level_data(_leader_score_array)
		json.middle_manager @results.first.change_socre_array_to_level_data(_middle_manager_score_array)
		json.staff @results.first.change_socre_array_to_level_data(_staff_score_array)

end


