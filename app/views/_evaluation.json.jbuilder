json.extract! evaluation, :id, :self_evaluation_id, :user_id, :already_edited, :created_year, :activity_id

json.info do
	json.( evaluation, :name, 
	:department_and_duty, :evaluating_user_type )
end

_duties = JSON.parse(evaluation.try(:duties))
_thought_morals = JSON.parse(evaluation.try(:thought_morals))
_upright_incorruptiable = JSON.parse(evaluation.try(:upright_incorruptiable))

json.content do 
	json.duties _duties
	json.thought_morals _thought_morals
	json.upright_incorruptiable _upright_incorruptiable
	json.(evaluation, :evaluation_totality) 
end