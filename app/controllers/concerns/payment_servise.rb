module PaymentServise
  extend ActiveSupport::Concern

  def payment(price, description)
    PayPal::SDK::REST::Payment.new(data(price, description))
  end

  private

  def get_order(id)
      Order.find(id) || Order.find_by_payment_id(id)
  end

  def add_role_follower
    role = Role.find_by_name('follower')
    @order.user.update_attributes(role: role) unless @order.user.role == 'admin'
  end

  def update_order(payment_id, state)
    @order = Order.find_by(payment_id: payment_id)
    @order.update!(state: state)
  end

  def data(price, description)
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
            return_url: 'http://localhost:3000/paypals/execute',
            cancel_url: 'http://localhost:3000' }
    }
  end
end