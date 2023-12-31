class Api::V1::WebpayController < ApplicationController
  before_action :authenticate_api_v1_user!, :set_booking, only: :pay

  def pay
    if @booking.unpaid? || @booking.in_process?
      if ENV['WEBPAY_ENV'].eql?'production'
        commerce_code = Rails.application.credentials.dig(:webpay, :commerce_code)
        api_key = Rails.application.credentials.dig(:webpay, :api_key)
        environment = ENV['WEBPAY_ENV'].to_sym
      else
        commerce_code = ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS
        api_key = ::Transbank::Common::IntegrationApiKeys::WEBPAY
        environment = 'integration'.to_sym
      end

      @tx = Transbank::Webpay::WebpayPlus::Transaction.new(commerce_code, api_key, environment)

      transaction_id = SecureRandom.hex(10)
      session_id = SecureRandom.hex(8)
      amount = @booking.time_slot.event.charges
      @resp = @tx.create(
        "#{transaction_id}", # unique transaction id
        "#{session_id}", # transaction session id which is valid for 5 to 10 minutes
        "#{amount}",
        "#{ENV['HOST_URL']}#{api_v1_webpay_redirect_path}"
      )

      if @booking.update(transaction_id: transaction_id, payment_status: :in_process)
        redirect_to "#{@resp['url']}?token_ws=#{@resp['token']}", allow_other_host: true
      else
        render json: { error: 'Booking Invalid!' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid Booking Request!' }, status: :unprocessable_entity
    end
  end

  def redirect
    # possible query params: token_ws=, TBK_ORDEN_COMPRA=081e04129cdddab5, TBK_ID_SESION=session_id321
    if params[:token_ws].present?
      begin
        @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS)
        @resp = @tx.commit("#{params[:token_ws]}")
      rescue => e
        return render(json: e.message, status: :forbidden)
      end

      @booking = Booking.find_by!(transaction_id: @resp['buy_order'])
      # {"vci"=>"TSY", "amount"=>20, "status"=>"AUTHORIZED", "buy_order"=>"7a3e13a820c14a6c", "session_id"=>"session_id321",
      # "card_detail"=>{"card_number"=>"6623"}, "accounting_date"=>"1222", "transaction_date"=>"2023-12-22T07:45:43.790Z",
      # "authorization_code"=>"1213", "payment_type_code"=>"VD", "response_code"=>0, "installments_number"=>0}


      if @resp['status'].eql?('AUTHORIZED') && @resp['response_code'].eql?(0)
        @booking.update_transaction(@resp)
        render json: 'Transaction successful.', status: :ok
      else
        render json: 'Unauthorized transaction!', status: :unauthorized
      end
    else
      render json: 'Invalid transaction!', status: :forbidden
    end
  end


  private

    def set_booking
      @booking = current_api_v1_user.bookings.find(params[:booking_id])
    end

end
