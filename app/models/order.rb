class Order < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :amount, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :service, presence: true
end
