class Client < ActiveRecord::Base

#####
	has_one :settings, class_name: 'ReferralSetting', foreign_key: 'client_id'
	has_many :codes, class_name: 'ReferralCode', foreign_key: 'client_id'
	has_many :referrals, through: :codes, source: :referrals

#####

	before_save { self.email = email.downcase }
	validates_presence_of :email
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "must be valid."
	validates_uniqueness_of :email, case_sensitive: false, message: "has already been taken"
	validates_uniqueness_of :entity_name, case_sensitive: false, message: "has already been taken"


	def compile_total_stats

		stats = {}
		stats["total_sent"] = self.codes.count.to_s
		stats["hits"] = self.referrals.where(converted: false).count.to_s
		stats["downloads"] = self.referrals.where(converted: true).count.to_s
		stats["registrations"] = self.referrals.where(converted: true, conversion_type: "registration").count.to_s

		stats["percent_converted"] = self.codes.count == 0 ? "n/a" : ((self.referrals.where(converted: true).count.to_f / self.codes.count.to_f) * 100.0).to_i.to_s + "%"
		stats["percent_converted_sms"] = self.codes.where(code_type: "sms").count == 0 ? "n/a" : ((self.getConversionsByType("sms").count.to_f / self.codes.count.to_f) * 100.0).to_i.to_s + "%"
		stats["percent_converted_email"] = self.codes.where(code_type: "email").count == 0 ? "n/a" : ((self.getConversionsByType("email").count.to_f / self.codes.count.to_f) * 100.0).to_i.to_s + "%"
		return stats
	end

	def compile_user_stats
		stats = {}
		stats["best_senders"] = self.codes.group("referral_codes.user_id").order("count_id desc").limit(5).count("id")
		stats["best_converters"] = self.codes.joins(:referrals).where(referrals: {converted: true}).group("referral_codes.user_id").order("count_id desc").limit(5).count("id")
		most_recently_refered = []
		for referral in Referral.where(conversion_type: "registration").order("updated_at desc").limit(5)
			most_recently_refered << {"referree": referral.converted_user, "referrer": referral.referral_code.user_id}
		end
		stats["recent_referrals"] = most_recently_refered
		return stats
	end

	def getConversionsByType(type)
		return self.referrals.joins(:referral_code).where(converted: true, referral_codes: {code_type: type})
	end

end