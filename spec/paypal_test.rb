require 'rails_helper'
require 'paypal-sdk-rest'
include PayPal::SDK::REST
RSpec.describe OrdersController, type: :controller do
  
  describe 'Paypal' do

    PaymentAttributes = {
          "intent" =>  "sale",
          "payer" =>  {
            "payment_method" =>  "credit_card",
            "funding_instruments" =>  [ {
              "credit_card" =>  {
                "type" =>  "visa",
                "number" =>  "4567516310777851",
                "expire_month" =>  "11", "expire_year" =>  "2018",
                "cvv2" =>  "874",
                "first_name" =>  "Joe", "last_name" =>  "Shopper",
                "billing_address" =>  {
                  "line1" =>  "52 N Main ST",
                  "city" =>  "Johnstown",
                  "state" =>  "OH",
                  "postal_code" =>  "43210", "country_code" =>  "US" } } } ] },
          "transactions" =>  [ {
            "amount" =>  {
              "total" =>  "1.00",
              "currency" =>  "USD" },
            "description" =>  "This is the payment transaction description." } ] }

    PaymentAttributesPayPal = {
          "intent" =>  "sale",
          "payer" =>  {
            "payment_method" =>  "paypal"
          },
          "redirect_urls" => {
            "return_url" => 'https://localhost/return',
            "cancel_url" => 'https://localhost/cancel',
          },
          "transactions" =>  [ {
            "amount" =>  {
              "total" =>  "1.00",
              "currency" =>  "USD" },
            "description" =>  "This is the payment transaction description." } ] }

    it "Validate user-agent", :unit => true do
      expect(API.user_agent).to match "PayPalSDK/PayPal-Ruby-SDK"
    end
    context "Payment" do
      it "Create with redirect urls" do
        payment = Payment.new(PaymentAttributesPayPal)
        # Create
        payment.create
        expect(payment.error).to be_nil
        expect(payment.id).not_to be_nil
        expect(payment.approval_url).to include('webscr?cmd=_express-checkout')
        expect(payment.approval_url).not_to include('useraction=commit')
        expect(payment.approval_url(true)).to eq payment.approval_url + '&useraction=commit'
        expect(payment.token).to match /^EC-[A-Z0-9]+$/
      end
      it "Create with client_id and client_secret" do
        api = API.new
        payment = Payment.new(PaymentAttributes.merge( :client_id => api.config.client_id, :client_secret => api.config.client_secret))
        expect(api).not_to eql payment.api
        payment.create
        expect(payment.error).to be_nil
        expect(payment.id).not_to be_nil
      end
      it "Find" do
        payment_history = Payment.all( "count" => 1 )
        payment = Payment.find(payment_history.payments[0].id)
        expect(payment.error).to be_nil
      end
      context "Validation", :integration => true do
        it "Create with empty values" do
          payment = Payment.new
          expect(payment.create).to be_falsey
        end
        it "Find with invalid ID" do
          expect {
            payment = Payment.find("Invalid")
          }.to raise_error PayPal::SDK::Core::Exceptions::ResourceNotFound
        end
        it "Find with nil" do
          expect{
            payment = Payment.find(nil)
          }.to raise_error ArgumentError
        end
        it "Find with empty string" do
          expect{
            payment = Payment.find("")
          }.to raise_error ArgumentError
        end
        it "Find record with expired token" do
          expect {
            Payment.api.token
            Payment.api.token.sub!(/^/, "Expired")
            Payment.all(:count => 1)
          }.not_to raise_error
        end
      end

      context "Sale", :integration => true do
        before :each do
          @payment = Payment.new(PaymentAttributes)
          @payment.create
          expect(@payment).to be_success
        end

        it "Find" do
          sale = Sale.find(@payment.transactions[0].related_resources[0].sale.id)
          expect(sale.error).to be_nil
          expect(sale).to be_a Sale
        end
      end
    end
  end
end
