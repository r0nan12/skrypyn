module LiqpayService
  extend ActiveSupport::Concern

  def build_liqpay(amount, id, description, service)
    Liqpay::Request.new(liqpay_data(amount, id, description)) if service == 'liqpay'
  end

  private

  def liqpay_data(amount, id, description)
    {
        sandbox: 1,
        amount: @order.amount,
        currency: 'UAH',
        order_id: @order.id,
        description: @order.article.title,
        result_url: 'http://'+request.host + '/success/' + id.to_s,
        server_url: 'http://'+request.host + orders_liqpay_path
    }
  end
end