module ResponseUtilities
#see http://labs.omniti.com/labs/jsend for meta response
#for data formatting, see:
#https://github.com/nesquena/rabl
#https://github.com/rails-api/active_model_serializers --> simpler
	#http://eewang.github.io/blog/2013/07/23/using-activemodel-serializers-to-build-great-json-interfaces/
	#https://blog.engineyard.com/2015/active-model-serializers
	def json_response(status_code, object = nil, custom_meta_hash = {})
		if status_code.blank?
			raise 'returns must specify status code and return'
		end
		if status_code/100 == 2
			status = 'success'
			if object.kind_of? String
				message = object
				object = nil
			end
		else
			status = 'error'
			message = object
			object = nil
		end

		if object.blank?
			object = []
		end
		meta = { status: status, code: status_code, message: message }.merge(custom_meta_hash)
		render json: object, status: status_code , meta: meta
	end

	private

end