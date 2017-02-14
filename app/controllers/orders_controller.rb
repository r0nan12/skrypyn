class OrdersController < ApplicationController
  include PaypalService
  include LiqpayService
  include StripeService
  protect_from_forgery except: :liqpay
  before_action :get_order, only: [:new, :stripe, :paypal]
  before_action :get_article, only: [:create_order, :new]

  def create_order
    @order = Order.new(order_params)
    if @order.save!
      redirect_to action: 'new', order_id: @order.id
    else
      flash[:error] = 'Order failed. ' + @order.errors.full_messages.to_sentence
    end
  end

  def new
    @liqpay_request = build_liqpay(@order.amount, @order.id, @order.article.title, @order.service)
  end

  def liqpay
    @liqpay_response = Liqpay::Response.new(params)
    order_id = @liqpay_response.order_id
    @order = Order.find(order_id)
    if @liqpay_response.success?
      update_order(@liqpay_response.transaction_id, @liqpay_response.amount)
    else
      flash[:error] = 'Payment failed'
    end
  end

  def stripe
    build_stripe((@order.amount*100).to_i, @order.article.title)
    update_order(@charge.id, (@charge.amount.to_f)/100)
    redirect_to action: 'success', id: @order.id
  end

  def paypal
    @payment = build_paypal(@order.article.price, @order.article.title)
    if @payment.create
      @order.update(payment_id: @payment.id, amount: @payment.transactions[0].amount.total)
      redirect_to @payment.links.find{ |link| link.rel  == 'approval_url' }.href
    else
      flash[:error] = 'Something went wrong'
      redirect_to root_path
    end
  end

  def execute_paypal
    payment_id = params[:paymentId]
    @order = Order.find_by_payment_id(payment_id)
    @payment = find_paypal(payment_id)
    if @payment.execute(payer_id: params[:PayerID])
      update_order(@payment.id, @payment.transactions[0].amount.total)
      redirect_to action: 'success', id: @order.id
    else
      flash[:error] = 'Payment failed'
      redirect_to root_path
    end
  end

  def success
    @order = Order.find(params[:id])
    CleanOrdersWorker.perform_async(@order.id)
  end

  private

  def update_order(payment_id, received_amount)
    @order.update(payment_id: payment_id, received_amount: received_amount)
    @order.approve! if @order.may_approve?
    add_role_follower
  end

  def get_order
    @order = Order.find(params[:order_id])
  end

  def get_article
    @article = Article.find(params[:id])
  end

  def add_role_follower
    role = Role.find_by_name('follower')
    if @order.approved?
      @order.user.update_attributes(role: role) unless @order.user.role == 'admin'
    end
  end

  def order_params
    params.require(:order).permit(:amount, :service).merge(article: @article, user: current_user)
  end
end