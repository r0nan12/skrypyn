class Order < ApplicationRecord
  include AASM

  belongs_to :article
  belongs_to :user
  validates :amount, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :service, presence: true

  aasm do
    state :pending, initial: true
    state :approved

    event :approve do
      transitions from: :pending, to: :approved, guard: :amount_checked?
    end
  end

  def amount_checked?
    amount == received_amount
  end

  def self.clear
    where('aasm_state != ?', 'approved').delete_all
  end
end
