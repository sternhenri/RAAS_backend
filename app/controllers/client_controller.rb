class ClientController < ApplicationController

	def settings
	    client = Client.find(params[:client_id])
		refSet = client.settings
		response = {
			entity_name: client.entity_name,
			settings: refSet
		}
	    json_response(200, response)
	end

	def changeSettings
	    client = Client.find(params[:client_id])
		refSet = client.settings
		refSet.update(changeParameters)
		json_response(200)
	end

	def referral_stats
	    client = Client.find(params[:client_id])
		response = client.compile_total_stats
		json_response(200, response)
	end

	def user_stats
	    client = Client.find(params[:client_id])
		response = client.compile_user_stats
		json_response(200, response)
	end

	private

	def changeParameters
	    params.permit(:is_active, :support_sms, :support_email, :referral_prompt, :referral_thanks)
	end
end