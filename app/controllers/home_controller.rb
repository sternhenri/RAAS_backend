class HomeController < ApplicationController

	skip_before_filter :check_format, :require_auth

	def index
		json_response(200, "Hello")
	end

	def test
		json_response(201, "Successful Test")
	end

	private

	def layout_name
	    if params[:layout] == 0
	        false
	    else
	        'application'
	    end
	end

end