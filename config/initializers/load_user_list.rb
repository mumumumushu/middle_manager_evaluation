class LoadUserList
	require 'roo'

	def self.load(input_file,output_path)
		MiddleManager.all.each do |m| 
			m.take_part_in = false
			m.password = Password.new #< == 
			m.save
		end

		xlsx = Roo::Excelx.new(input_file)
		file = File.new("#{output_path}password.txt", "w")

		4.upto( LoadUserList.get_sum(xlsx) ).each do |row|
			# ActiveRecord::Base.transaction do
				_middle_manager = MiddleManager.where( "job_num = ?", LoadUserList.get_job_num(row,xlsx)).first ||  MiddleManager.new
				_middle_manager.job_num = LoadUserList.get_job_num(row,xlsx)
				_middle_manager.user_type = 'middle_manager'
				_middle_manager.take_part_in = true
				_middle_manager.password = Password.new
				_middle_manager.save

				_user_info = UserInfo.new
				_user_info.user_id = _middle_manager.id

				_user_info.name = LoadUserList.get_name(row,xlsx)
				_user_info.sex = LoadUserList.get_sex(row,xlsx)
				_user_info.date_of_birth = LoadUserList.get_birth(row,xlsx)
				_user_info.degree_of_education = LoadUserList.get_degree_of_education(row,xlsx)
				_user_info.politics_status = LoadUserList.get_politics_status(row,xlsx)
				_user_info.department_and_duty = LoadUserList.get_department(row,xlsx) + "  " + LoadUserList.get_duty(row,xlsx)
				_user_info.starting_time_for_the_present_job = LoadUserList.get_time(row,xlsx)

				_user_info.save		

				file.write("姓名: #{_user_info.name},  工号: #{_middle_manager.job_num},  密码: #{_middle_manager.password}\n")
			# end
		end

		file.close
		# rescue => e
		# 	e
	end

	
	def self.get_sum(xlsx)
		i = 0
		xlsx.each_row_streaming do |row| 
			i += 1  
		end	 
		i - 2
	end

	def self.get_job_num(row,xlsx)
		job_num = xlsx.formatted_value(row,"B")
	end

	def self.get_name(row,xlsx)
		name = xlsx.formatted_value(row,"C")
		if name.include?(" ")# or name.include?("<")
			_x = /([\u4e00-\u9fa5]).+([\u4e00-\u9fa5])/.match( name) 
			name = _x[1] + _x[2]
		else
			name = name.strip
		end
	end

	def self.get_sex(row,xlsx)
		sex = xlsx.formatted_value(row,"D")
	end

	def self.get_politics_status(row,xlsx)
		politics_status = xlsx.formatted_value(row,"F")
	end

	def self.get_birth(row,xlsx)
		birth = xlsx.formatted_value(row,"G")
		if birth.include?("/")
			_x = /(\d+)\/(\d+)\/(\d+)/.match(birth) || /(\d+)\/(\d+)/.match(birth)
			birth = _x[3] ? "#{_x[1]}.#{_x[2]}.#{_x[3]}" : "#{_x[1]}.#{_x[2]}"
		else
			_x = /(\d+)-(\d+)-(\d+)/.match(birth) #["11-17-68",
			birth = "19#{_x[3]}.#{_x[1]}.#{_x[2]}"
		end
	end

	def self.get_degree_of_education(row,xlsx)
		degree_of_education = xlsx.formatted_value(row,"K")
	end

	def self.get_department(row,xlsx)
		department = xlsx.formatted_value(row,"O")
	end

	
	def self.get_duty(row,xlsx)
		duty = xlsx.formatted_value(row,"P").tr_s("\n",", ")	
	end

	def self.get_time(row,xlsx)
		time = xlsx.formatted_value(row,"Q")
		if time.include?("\n") or time.include?(".")
			time = time.tr_s("\n", " ")
			time = time.tr_s("/", ".")
			time = time.tr_s("-", ".")
		else
			_x = /(\d+)-(\d+)-(\d+)/.match(time)
 			time = "20#{_x[3]}.#{_x[1]}.#{_x[2]}"
		end
	end
end


class OutputResultIndex
	require 'roo'
	def do
		
	end
end