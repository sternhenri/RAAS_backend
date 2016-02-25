class String

	def to_boolean
		return (self.downcase == 'true' or self.downcase == '1' or self.downcase == 'yes')
	end

	def to_date
		return Date.strptime(self, "%m-%d-%Y")
	end

end