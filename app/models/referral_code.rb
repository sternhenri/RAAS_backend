class ReferralCode < ActiveRecord::Base

	belongs_to :client
	has_many :referrals, foreign_key: 'referral_code_id'

	def self.generate(params)

		user_invite = ReferralCode.new(client_id: params[:client_id])
		method = params[:user_token].present? ? lambda{ |arg| user_invite.user_code(arg) } : lambda{ |arg| user_invite.random_code }
		code = method.call(params[:user_token])
		while(ReferralCode.exists?(client_id: params[:client_id], code: code))
			code = method.call(params[:user_token])
		end

		user_invite.code = code

		return user_invite
	end

	def random_code()
		return ('a'..'z').to_a.shuffle[0,8].join
	end

	def user_code(token)
		#make dynamic
		keywords = ['rocks', 'rules', 'luck', 'love']
		return token + "_" + keywords[rand(0...keywords.length)].to_s + rand(0..100).to_s
	end

end