json.extract! evaluation, :id, :self_evaluation_id, :user_id, :already_edited, :created_year, :activity_id

json.info do
	json.( evaluation, :name, 
	:department_and_duty, :evaluating_user_type )
end

json.content do 

	json.thought_morals evaluation.change_output_format("thought_morals")

	json.duties evaluation.change_output_format("duties")

	json.upright_incorruptiable evaluation.change_output_format("upright_incorruptiable")

	json.(evaluation, :evaluation_totality) 
	
end
