module StripeService
  extend ActiveSupport::Concern

  def build_stripe(amount, description)
    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
    )
    @charge = Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        description: description,
        currency: 'usd'
    )
  end
end