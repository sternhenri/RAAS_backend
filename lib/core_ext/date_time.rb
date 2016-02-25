class DateTime

	def self.create_from_date_and_time(given_date, given_time)
		return DateTime.new(given_date.year, given_date.month, given_date.day, given_time.hour, given_time.min, given_time.sec)
	end

	def to_string
		return self.strftime("%m-%d-%Y")
	end
	
end