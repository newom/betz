class PaymentController < ApplicationController  
	require 'paypal-sdk-adaptivepayments'
  
  def execute
    
    

    @payment = Payment.find(params[:paymentId])
    if @payment.execute(:payer_id => params[:PayerID])
    	redirect_to open_user_path(session[:user_id])
    	byebug
    else
    	logger.error @payment.error.inspect
    end
  end

end