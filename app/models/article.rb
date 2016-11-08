class Article < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 5,maximum: 255 }
  validates :text, presence: true,
                    length: { minimum: 5 }
  belongs_to :user
  has_many :coments




  def calculate_coments
    write_attribute :total_coments, coments.map(&:id).size
    self.save
    self.total_coments
  end

  def self.search(param)
      query = "%#{param}%"
      where('lower(title) LIKE ?', query)
  end

  end
