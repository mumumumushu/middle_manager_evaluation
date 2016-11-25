json.extract! self_evaluation,  :id, :middle_manager_id, :activity_id, :created_year, :created_at, :updated_at

json.info do
	json.(self_evaluation, :name, :department_and_duty, :job)
end

json.content do
	json.duties self_evaluation.try(:duties_output)
	json.(self_evaluation, :self_evaluation_totality)
end
