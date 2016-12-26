class CleanOrdersWorker
  include Sidekiq::Worker

  def perform(id)
    view = ActionView::Base.new
    @order = Order.find(id)
    view.view_paths = ActionController::Base.view_paths
    view.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end
    pdf_html = view.render template: 'orders/success.html.erb', locals: { order: @order }
    success_pdf = WickedPdf.new.pdf_from_string(pdf_html)
    OrdersMailer.thanks_for_order_email(@order.user, success_pdf).deliver_now
  end
end
