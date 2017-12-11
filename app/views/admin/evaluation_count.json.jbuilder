json.array! @users.each do |user|
	json.job_num user.job_num
	json.name	user.info.name
	json.edited_count user.evaluations.activity_id_is(@activity.id).edited.count
	json.unedited_count user.evaluations.activity_id_is(@activity.id).unedited.count
	json.self_evaluation_edited(user.user_type.eql?('middle_manager') ? @activity.self_evaluations.where(middle_manager: user).first.already_edited : nil)
end