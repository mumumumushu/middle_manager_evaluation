json.array! @users.each do |user|
	json.job_num user.job_num
	json.edited_count user.evaluations.activity_id_is(@activity.id).edited.count
	json.unedited_count user.evaluations.activity_id_is(@activity.id).unedited.count
end