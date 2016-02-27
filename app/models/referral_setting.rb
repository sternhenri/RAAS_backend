#cache as seldom changed
#convert to editable yml or something

class ReferralSetting < ActiveRecord::Base
   
	belongs_to :client	 
end