require 'spec_helper'
require 'support/controller_macros'

describe OrdersController do
  login_user('admin')
  PayPalAttributes = {
      intent: 'sale',
      payer: {
          payment_method: 'paypal' },
      transactions: [{
        item_list: {
            items: [{
              name: 'article',
              price: '10',
              currency: 'USD',
              quantity: 1 }]},
        amount: {
            total: '10',
            currency: 'USD' },
        description: 'article' }],
      redirect_urls: {
          return_url: 'http://localhost:3000/orders/execute_paypal',
          cancel_url: 'http://localhost:3000' }
  }

  describe 'PayPal' do
    it 'Create action' do
      payment = PayPal::SDK::REST::Payment.new(PayPalAttributes)
      payment.create
      expect(payment.id).not_to be_nil
      expect(payment.approval_url).not_to be_nil
      expect(payment.token).not_to be_nil
    end
  end
end