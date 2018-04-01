# require 'paypal-sdk-rest'
class OrdersController < ApplicationController
  before_action :get_order#, only: [:show, :edit, :update, :payment]

  def show
    @order_items = current_order.order_items
    @limit_order_items = @order_items.page(params[:page]).per(1)
  end

  def payment
    # Build Payment object
    @payment = PayPal::SDK::REST::Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal" },
      :redirect_urls => {
        :return_url => 'http://localhost:3000' + payment_order_path(params[:id]),
        :cancel_url => 'http://localhost:3000' + products_path },
      :transactions =>  [{
        :amount =>  {
          :total =>  @order.subtotal,
          :currency =>  "USD" },
        :description =>  "This is the payment transaction description." }]})

      if @payment.create
        @payment.id     # Payment Id
      else
        @payment.error  # Error Hash
      end
      if !params[:token].nil? && !params[:PayerID].nil?
          @order.update(payment_id: params[:paymentId],
                      token_payment: params[:token],
                      payer_id: params[:PayerID])
      end
  end
  def execute
    @payment = PayPal::SDK::REST::Payment.find(@order.payment_id)
    if @payment.execute( :payer_id => @order.payer_id   )
      @order.update(order_status_id: 3) #Recevied
      if user_signed_in?
        @order.update(user_id: current_user.id)
      else
        redirect_to user_session_path
      end
      current_order = Order.create
      session[:order_id] = current_order.id
      flash[:notice] = 'Payment success!'
      redirect_to root_path
    else
       flash[:notice] = @payment.error # Error Hash
       redirect_to order_path(@order)
    end
  end

  private
    def get_order
      @order = Order.find(params[:id])
    end
end
