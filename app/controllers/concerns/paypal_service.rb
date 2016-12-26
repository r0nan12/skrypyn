module PaypalService
  extend ActiveSupport::Concern

  def build_paypal(price, description)
    PayPal::SDK::REST::Payment.new(paypal_data(price, description))
  end

  def find_paypal(id)
    PayPal::SDK::REST::Payment.find(id)
  end

  private

  def paypal_data(price, description)
    {
        intent: 'sale',
        payer: {
            payment_method: 'paypal' },
        transactions: [{
          item_list: {
              items: [{
                name: 'article',
                price: price,
                currency: 'USD',
                quantity: 1 }]},
          amount: {
              total: price,
              currency: 'USD' },
          description: description }],
        redirect_urls: {
            return_url: 'http://localhost:3000/orders/execute_paypal',
            cancel_url: 'http://localhost:3000' }
    }
  end
end