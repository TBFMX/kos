class GatewayController < ApplicationController
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include CurrentCart
  before_action :set_cart
  
  
  def index

  end

  def paypal

  	#quitar cuando acaben las pruebas flash
  	require 'paypal-sdk-rest'
	#include  PayPal::SDK::REST

	PayPal::SDK::REST.set_config(
	  :mode => "sandbox", # "sandbox" or "live"
	  :client_id => "AUsuAxDDr6_WcMNrnWkpdiKl6UoNZT9YTcT-n2Cd1BpGU386PFJaw6TBhADy",
	  :client_secret => "ENy1ehBI9RRdcP8800N5B7GZt8ZEclcxca8UYRAtZcSLGA7haQFpMdRmmceg")
  	#@pago= :params[:all]
  	@total = sprintf("%0.02f", @cart.total_price)
#@total = @cart.total_price.to_d
  	@payment = PayPal::SDK::REST::Payment.new({
	  :intent => "sale",
	  :redirect_urls => {
	    	:return_url => "http://tbf.mx",
	    	:cancel_url => "http://google.com"},
	  :payer => {
	    :payment_method => "paypal"
		},
	  :transactions => [{
	    :amount => {
	      :total => @total,
	      :currency => "MXN",
	      :details => {
	        :subtotal => @total,
	        :tax => "0.00",
	        :shipping => "0.00"}},
	    :description => "Gastos de Manga" + @total + "" }]})

	if @payment.create
	  respuesta = true	
	  @T_id = @payment.id     # Payment Id
	  session[:lastid]= @T_id
	  #puts respuesta
	  #puts  @T_id

	  get_payment_details(@T_id)
	  

	  #execute_payment(@T_id)

	else
	  respuesta = false	
	  @T_error = @payment.error  # Error Hash

	  #puts respuesta
	  #puts @T_error
	end
  end


  def pago_paypal
  	pl_id = params[:PayerID]
  	execute_payment(session[:lastid],pl_id)
  end

  def dineromail
  end

    def mercadopago

  	    require 'mercadopago.rb'
	  	$mp = MercadoPago.new('643761609226418', '9QJmWMLdqkUV8Mi4jk0qluhubnP0QqRl')

	  	$accessToken = $mp.get_access_token()

		puts $accessToken

		#preferenceData = Hash["items" => Array(Array["title"=>"testCreate", "quantity"=>1, "unit_price"=>10.2, "currency_id"=>"ARS"])]
		$auxarray = Array.new
		$contador=0

		@cart.line_items.each do |line_item|
			$auxarray[$contador]={"title"=>line_item.product.title.to_s, "quantity"=>line_item.quantity, "unit_price"=>line_item.total_price.to_s.to_f, "currency_id"=>"MXN"}
			$contador += 1
		end
		# 
		#puts $auxarray
		preferenceData = Hash["items" => $auxarray]

	    #puts preferenceData 

		preference = $mp.create_preference(preferenceData)

		#puts preference["response"]["sandbox_init_point"]

		@liga = preference["response"]["sandbox_init_point"]
		@trans_id = preference["response"]["id"]

		@respuesta = get_notification($mp,@trans_id)
    end




  private

  def get_notification(mp,trans_id)
  	paymentInfo = mp.get_payment_info(trans_id)

	return paymentInfo
  end

  def get_payment_details(pp_id)
  	# Fetch Payment
	payment = Payment.find(pp_id)

	# Get List of Payments
	payment_history = Payment.all( :count => 1 )
	@grid = payment_history.payments #<--para grid
  end

  def execute_payment(pp_id,pl_id)
  	payment = Payment.find(pp_id)

	if payment.execute( :payer_id => "V2JJCS4BQJVJC" )
	  # Success Message
	  @mensajePP = "el pago se realizo con exito"
	else
	  @mensajePP = payment.error # Error Hash
	end
  end	

end
