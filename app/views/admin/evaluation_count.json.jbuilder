@users.each do |user|
	json.set! user.job_num do
		json.edited_count user.evaluations.activity_id_is(@activity.id).edited.count
		json.unedited_count user.evaluations.activity_id_is(@activity.id).unedited.count
	end
end