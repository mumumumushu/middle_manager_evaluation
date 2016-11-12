class DateFormatConversion < ActiveRecord::Base

	def self.string_into_array string #one dimensional array
		if string
			_detail = string.split(";")
			_detail.map do |a| 
				a.split(",")
			end
		end
	end



end