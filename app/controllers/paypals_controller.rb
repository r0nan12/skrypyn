class PaypalsController < ApplicationController
  include PaymentServise

  def create
    @order = get_order(params[:id])
    @payment = payment(@order.article.price, @order.article.title)
    if @payment.create
      @order.update(payment_id: @payment.id, state: @payment.state)
      redirect_to @payment.links.find{ |link| link.rel  == 'approval_url' }.href
    else
      flash[:danger] = 'Something went wrong'
      redirect_to root_path
    end
  end

  def execute
    payment_id = params[:paymentId]
    @payment =  PayPal::SDK::REST::Payment.find(payment_id)
    if @payment.execute(payer_id: params[:PayerID])
      update_order(payment_id, @payment.state)
      redirect_to execute_order_path(@order)
    else
      flash[:danger] = 'Payment failed'
      redirect_to root_path
    end
  end
end