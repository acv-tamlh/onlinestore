require 'paypal-sdk-rest'
include PayPal::SDK::REST
class OrdersController < ApplicationController
  before_action :get_order#, only: [:show, :edit, :update, :payment]

  # PayPal::SDK::REST.set_config(
  #   :mode => "sandbox", # "sandbox" or "live"
  #   :client_id => "AdDP6Z0PVwCQ3Zu-qd0cFiBJ_whQ2zNLxNV2jQdhfnUXKCiCv69e-pC1vJXPYaDGTm2ZcPyrrAKT2NZc",
  #   :client_secret => "EKmDJLzG8nW4tDtJUV8NdN9yJ5we5qvW_QxTSjBzXb4pqZ5nqRcBuYl8hJ2sv8ky6BPCNrP1qxAEPLRO")

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
        :return_url => payment_order_path(params[:id]),
        :cancel_url => products_path },
      :transactions =>  [{
        :amount =>  {
          :total =>  @order.subtotal,
          :currency =>  "USD" },
        :description =>  "This is the payment transaction description." }]})
        # binding.pry

      if @payment.save
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
      @order.update(status: true)
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
