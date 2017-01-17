
_leader_score_array = []
_middle_manager_score_array = []
_staff_score_array = []
_average_score_for_all_array = []

json.table do
	json.array! @results.each	do |result|
		json.(result, :id, :name, :average_score_for_leader, :average_score_for_middle_manager, :average_score_for_staff, :average_score_for_all, :final_result, :output_of_level_of_average_score_for_all)

		_leader_score_array += [result.average_score_for_leader]
		_middle_manager_score_array += [result.average_score_for_middle_manager]
		_staff_score_array += [result.average_score_for_staff]
		_average_score_for_all_array += [result.average_score_for_all]

	end
end

json.statistics do

		json.leader Result.change_score_array_to_level_data(_leader_score_array)
		json.middle_manager Result.change_score_array_to_level_data(_middle_manager_score_array)
		json.staff Result.change_score_array_to_level_data(_staff_score_array)
		json.average_for_all Result.change_score_array_to_level_data(_average_score_for_all_array)

end


