json.extract! evaluation, :id, :self_evaluation_id, :user_id, :already_edited, :created_year, :activity_id

json.info do
	json.( evaluation, :name, 
	:department_and_duty, :evaluating_user_type )
end

json.content do 
	json.( evaluation, :thought_morals, :duties,
	:upright_incorruptiable,  
	:evaluation_totality, 
	)
end