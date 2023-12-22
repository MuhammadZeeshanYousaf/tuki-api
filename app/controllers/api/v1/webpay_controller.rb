class Api::V1::WebpayController < ApplicationController

  def pay
    if ENV['WEBPAY_ENV'].eql?'production'
      # set production credentials
    else
      commerce_code = ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS
      api_key = ::Transbank::Common::IntegrationApiKeys::WEBPAY
      environment = 'integration'.to_sym
    end

    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(commerce_code, api_key, environment)
    @resp = @tx.create(
      "#{SecureRandom.hex(8)}", # unique transaction id
      'session_id321', # transaction session id which is valid for 5 to 10 minutes
      20,
      "#{ENV['HOST_URL']}#{api_v1_webpay_path}"
    )

    redirect_to "#{@resp['url']}?token_ws=#{@resp['token']}", allow_other_host: true
  end

  def show
    if params[:token_ws].present?
      @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS)
      @resp = @tx.commit("#{params[:token_ws]}")

      # {"vci"=>"TSY", "amount"=>20, "status"=>"AUTHORIZED", "buy_order"=>"7a3e13a820c14a6c", "session_id"=>"session_id321",
      # "card_detail"=>{"card_number"=>"6623"}, "accounting_date"=>"1222", "transaction_date"=>"2023-12-22T07:45:43.790Z",
      # "authorization_code"=>"1213", "payment_type_code"=>"VD", "response_code"=>0, "installments_number"=>0}

      if @resp['status'].eql?'AUTHORIZED'
        render json: 'Transaction successful.', status: :ok
      else
        render json: 'Unauthorized transaction!', status: :unauthorized
      end
    else
      render json: 'Invalid transaction!', status: :not_acceptable
    end
  end

  def create
    puts 'CREATE-----------SHOWING RETURN PARAMS:', params
  end


end
