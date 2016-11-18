class HomeController < ApplicationController

	def get_home_info
		@activity = Activity.last
		# if Time.now >= @activity.first_phase_begin && Time.now <= @activity.third_phase_end
			respond_with @activity, template: 'activities/activity', status: 200
		# else
		# 	@error = { error: "最新的考核活动未上线"}
		# 	respond_with @error, template: 'error'
		# end
	end

end