class OrdersController < ApplicationController
  before_action :get_article, only: [:new, :create]

  def new
  end

  def create
    @order = Order.new(order_params)
    unless @order.save!
      flash[:danger] = 'Order failed. Please try again'
      redirect_to :back
    else
      redirect_to new_order_stripe_path(@order) if params[:order][:service] == 'stripe'
      redirect_to paypals_create_order_path(@order) if params[:order][:service] == 'paypal'
    end
  end

  def execute
    @order = Order.find(params[:id])
    flash[:success] = 'Successful payment'
    redirect_to article_path(@order.article)
  end

  private

  def order_params
    params.require(:order).permit(:amount, :service).merge(article: @article, user: current_user)
  end

  def get_article
    @article = Article.find(params[:article_id])
  end
end