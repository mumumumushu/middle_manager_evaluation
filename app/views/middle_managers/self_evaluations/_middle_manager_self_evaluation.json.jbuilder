json.extract! self_evaluation,  :id, :middle_manager_id, :activity_id, :created_year, :created_at, :updated_at

json.info do
	json.(self_evaluation, :name, :department_and_duty), :evaluated_user_info
end

_duties = JSON.parse(self_evaluation.try(:duties))

json.content do
	json.duties _duties
	json.(self_evaluation, :self_evaluation_totality)
end
