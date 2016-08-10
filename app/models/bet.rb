class Bet < ActiveRecord::Base

	attr_accessible :user1, :user2, :prop, :wager, :category, :winner, :paid, :date, :proposer;

	validates :prop, presence: true, length: {in: 5...500}

	validates :wager, presence: true, numericality: true

	validates :category, length: {in: 2...12}

	def group
		group_id = self.group_id
		Group.find(group_id)
	end

	def Bet.pay(receiver, amount, bet)

    require 'paypal-sdk-adaptivepayments'
    
    PayPal::SDK.load('config/paypal.yml', ENV['RACK_ENV'] || 'development')

    #PayPal::SDK.configure(
      #:mode      => "sandbox",  # Set "live" for production
      #:app_id    => "APP-80W284485P519543T",
      #:username => "attyowenmurphy-facilitator_api1.gmail.com",
      #:password => "BGEEFMZQ3GFFBDZT",
      #:signature => "A2Nrloz3u3YaqrAYMQ4lJlvClUQQAW1GzsAWS.Vcx12w-xDWYqT1mWdp" )

    @api = PayPal::SDK::AdaptivePayments.new

    # Build request object
    @pay = @api.build_pay({
      :actionType => "PAY",
      :cancelUrl => "http://localhost:3000/",
      :currencyCode => "USD",
      #:feesPayer => "SENDER",
      :ipnNotificationUrl => "http://localhost:3000/",
      :receiverList => {
        :receiver => [{
          :amount => amount,
          :email => receiver }]},
      :returnUrl => "http://localhost:3000/bets/#{bet}/paid" })

    # Make API call & get response
    @response = @api.pay(@pay)

    #@set_payment_options = @api.build_set_payment_options({
      #:payKey => @response.payKey,
      #:receiverOptions => [{
        #:receiver => {
          #:email => receiver }}]})
    # Access response
    if @response.success?
      return @response = { 
        :payKey => @response.payKey,
        :paymentExecStatus => @response.paymentExecStatus,
        :payErrorList => @response.payErrorList,
        :paymentInfoList => @response.paymentInfoList,
        :sender => @response.sender,
        :defaultFundingPlan => @response.defaultFundingPlan,
        :warningDataList => @response.warningDataList}
        byebug
    else
      @response.error
    end

		# require 'paypal-sdk-rest'
		# include PayPal::SDK::REST
		# include PayPal::SDK::Core::Logging

		# # ###Payment
		# # A Payment Resource; create one using
		# # the above types and intent as 'sale'
		# @payment = Payment.new({
  # 			:intent =>  "sale",

  # 			# ###Payer
  # 			# A resource representing a Payer that funds a payment
  # 			# Payment Method as 'paypal'
  # 			:payer =>  {
  #   			:payment_method =>  "paypal" },

  # 			:receiverList => {
  # 				:receiver => [{
  # 					:amount => amount,
  # 					:email => receiver}]},
  # 			# ###Redirect URLs
  # 			:redirect_urls => {
  #   			:return_url => "http://localhost:3000/payment/execute",
  #   			:cancel_url => "http://localhost:3000/" },

  # 			# ###Transaction
  # 			# A transaction defines the contract of a
  # 			# payment - what is the payment for and who
  # 			# is fulfilling it.
  # 			:transactions =>  [{
  #   			# Item List
  #   			#:item_list => {
  #     				#:items => [{
  #       				#:name => "item",
  #       				#:sku => "item",
  #       				#:price => "5",
  #       				#:currency => "USD",
  #       				#:quantity => 1 }]},
  #   			# ###Amount
  #   			# Let's you specify a payment amount.
  #   			:amount =>  {
  #     				:total =>  "5",
  #     				:currency =>  "USD" },
  #   			:description =>  description }]})

		# # Create Payment and return status
		# if @payment.create
  # 		# Redirect the user to given approval url
  # 			@redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
  # 			logger.info "Payment[#{@payment.id}]"
  # 			logger.info "Redirect: #{@redirect_url}"
  # 			byebug
		# else
  # 			logger.error @payment.error.inspect
  # 			byebug
		# end

		return @redirect_url
	end
end