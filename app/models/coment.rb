class Coment < ApplicationRecord
  belongs_to :article, required: false
  belongs_to :user
  validates :text, presence: true, length: { maximum: 255 }
end
