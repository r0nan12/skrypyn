class StripesController < ApplicationController
  include PaymentServise

  def new
    @order = get_order(params[:order_id])
  end

  def create
    @order = get_order(params[:order_id])
    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
    )
    @charge = Stripe::Charge.create(
        customer: customer.id,
        amount: (@order.amount*100).to_i,
        description: @order.article.title,
        currency: 'usd'
    )
    update_order(@charge.id, @charge.status)
  end
end