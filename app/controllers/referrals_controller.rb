class ReferralsController < ApplicationController

  # Get Settings for mobile SDK
  #
  # @note GET '/referrals/configure'
  # @param client_id [Integer] id of client
  #
  # @return [String] 'entity_name' --> Name of Client
  # @return [Hash] 'settings' --> 
  # @return [Boolean] 'is_active' --> enable client side sharing
  # @return [Boolean] 'support_sms' --> support texting
  # @return [Boolean] 'support_email' --> support email
  # @return [String] 'referral_prompt' --> client share message
  # @return [String] 'referral_thanks' --> client thanks message
  def configure
    refSet = ReferralSetting.find_by_client_id(params[:client_id])
    entity_name = Client.find(params[:client_id]).entity_name 
    #create if don't exist
    refSet.referral_prompt = "Check out " + entity_name + "!" unless refSet.referral_prompt.present?
    refSet.referral_thanks = "You rock!" unless refSet.referral_thanks.present?
  
    response = {
      entity_name: entity_name,
      settings: refSet
    }
    json_response(200, response)
  end

  # Generate new share code
  #
  # @note GET '/referrals/initiate'
  # @param client_id [Integer] id of client
  # @param user_id [Integer] id of user
  # @param client_id [Integer] id of client
  # @param client_token [String] client token for custom codes, optional
  #
  # @return [String] 'code' --> unique user code (per client)
  def get_code
    code = ReferralCode.generate(codeCreationParams)
    json_response(200, code)
  end

  # Mark code as sent (save to db)
  #
  # @note POST '/referrals/sent'
  # @param client_id [Integer] id of client
  # @param user_id [Integer] id of user
  # @param code [String] code
  # @param code_type [String] how the code was used: "email", "sms"  
  def code_sent
    #need to load with user profile so can be done offline: drafts, etc
    #some auth work tbd  
    ReferralCode.create(codeSentParams)
    return json_response(201)
  end

  # Mark code hit
  #
  # @note GET '/referrals/:company/:code'
  # @note redirect_to client app store link, store ip
  def code_hit
    wanted_client = Client.where("lower(entity_name) = ?", params[:company_name].downcase).first
    if wanted_client.present?
      code = wanted_client.codes.where(code: params[:code]).first
      if code.present?
        referral = wanted_client.referrals.where(ip: request.remote_ip)
        if !referral.present?
          #for now no counting multiple visits by same user
          Referral.create(referral_code_id: code.id, ip: request.remote_ip)
        end
          return redirect_to wanted_client.app_store_url, status: 302
      end
    end
    
    return json_response(404)
    
  end

  # Mark download
  #
  # @note PUT '/referrals/download'
  # @note pull ip from user
  def record_download
    client = Client.find(params[:client_id])
    referral = client.referrals.where(ip: request.remote_ip).first
    if (referral.present?)
      referral.update(converted: true, conversion_type: "download")
      return json_response(200)
    end
    return json_response(404)
  end

  # Mark registration
  #
  # @note PUT '/referrals/registration'
  # @note pull ip from user
  def record_registration
    client = Client.find(params[:client_id])
    referral = client.referrals.where(ip: request.remote_ip).first
    if (referral.present?)
      referral.update(converted: true, conversion_type: "registration", converted_user: params[:user_id])
      return json_response(200)
    end
    return json_response(404)
  end

	private

  def codeCreationParams
    params.permit(:client_id, :user_id, :user_token)
  end

  def codeSentParams
    params.permit(:client_id, :user_id, :code, :code_type)
  end


end