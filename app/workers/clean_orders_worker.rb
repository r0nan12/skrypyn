class CleanOrdersWorker
  include Sidekiq::Worker

  def perform(id)
    OrderConfirmationService.new(id).send_mail
  end
end
