json.extract! result, :id, :self_evaluation_id 

json.info do 
	json.( result, :name, :department_and_duty )
end

json.self_evaluation do
	json.( result, :self_evaluation_duties, :self_evaluation_totality )
end

json.little_iterm do
	json.( result, :sum_of_level_count, :level_count_and_percentage )
end

json.average_for_all_evaluation do
	json.( result, :sum_of_result_level_count, :result_level_count_and_percentage)
end

json.average_for_each_role do
	json.( result, :average_score_for_staff, :average_score_for_middle_manager, :average_score_for_leader)
end 

json.statistics_result do
	json.( result, :average_score_for_all, :level_of_average_score_for_all)
end

json.set_by_admin do
	json.( result, :final_result, :updated_at)	
end

json.count_of_people do 
	json.( result, :count_of_middle_manager, :count_of_all_user)
end
