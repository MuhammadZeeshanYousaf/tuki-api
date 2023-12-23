class Api::V1::WebpayController < Api::V1::BaseController
  skip_after_action :authenticate_api_v1_user!, :authenticate_super_admin!, :set_community, only: [:show, :create]
  before_action :verify_authenticity_token, only: [:show, :create]
  before_action :set_booking, only: :pay

  def pay
    puts 'params here--------------------', params
    if ENV['WEBPAY_ENV'].eql?'production'
      # set production credentials
    else
      commerce_code = ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS
      api_key = ::Transbank::Common::IntegrationApiKeys::WEBPAY
      environment = 'integration'.to_sym
    end

    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(commerce_code, api_key, environment)
    puts 'TRANSACTION: ', @tx.inspect
    @resp = @tx.create(
      "#{SecureRandom.hex(8)}", # unique transaction id
      'session_id321', # transaction session id which is valid for 5 to 10 minutes
      20,
      "#{ENV['HOST_URL']}#{api_v1_webpay_path}"
    )

    puts 'URL: ', @resp['url'], @resp['token']
    redirect_to "#{@resp['url']}?token_ws=#{@resp['token']}", allow_other_host: true
  end

  def show
    puts 'SHOW-----------SHOWING RETURN PARAMS:', params
    # possible query params: token_ws=, TBK_ORDEN_COMPRA=081e04129cdddab5, TBK_ID_SESION=session_id321
    if params[:token_ws].present?
      @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS)
      @resp = @tx.commit("#{params[:token_ws]}")

      puts 'RETURN RESPONSE:', @resp
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


  private

  def set_booking
    @booking = current_api_v1_user.bookings.find(params[:booking_id])
  end


end
