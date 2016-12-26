class OrdersMailer < ApplicationMailer
  def thanks_for_order_email(user, pdf)
    @user = user
    attachments['Order.pdf'] = pdf
    mail(to: @user.email, subject: 'Thanks for order')
  end
end