class OrderConfirmationService
  def initialize(id)
    @id = id
    @view = ActionView::Base.new
  end

  def send_mail
    OrdersMailer.thanks_for_order_email(order.user, pdf).deliver_now
  end

  private

  def view
    @view.view_paths = ActionController::Base.view_paths
    @view.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end
  end

  def order
    @order = Order.find(@id)
  end

  def pdf
    view
    pdf_html = @view.render template: 'orders/success.html.erb', locals: { order: order }
    return success_pdf = WickedPdf.new.pdf_from_string(pdf_html)
  end
end