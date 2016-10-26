class Password

	def self.new
		chars =  ('0'..'9').to_a #('a'..'z').to_a + ('A'..'Z').to_a
  	Array.new(6).collect{chars[rand(chars.size - 1)]}.join 
	end

end