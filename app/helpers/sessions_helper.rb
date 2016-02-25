module SessionsHelper

	def log_in(user)
		# Only used upon login and create
		@current_user = user
	end

	def remember(user)
		user.remember
	end
	# Returns the current logged-in user (if any).
	def current_user
		temp_user = @current_user
		if temp_user
			@current_user = nil
			return temp_user
		end
		if (user_id = request.headers['id'].to_i)#mobile
			auth_token = request.headers['token']
		else
			return nil
		end
		user = User.find_by(id: user_id)
		if user && user.authenticated?(auth_token)
			@current_user = user
		end
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		current_user.present?
	end

	# Logs out the current user.
	def log_out
		@current_user = nil
	end


end