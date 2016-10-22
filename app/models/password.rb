class Password

	def self.new
		chars = ('a'..'z').to_a + ('0'..'9').to_a #+ ('A'..'Z').to_a
  	Array.new(6).collect{chars[rand(chars.size - 1)]}.join 
	end

end