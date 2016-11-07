class Article < ApplicationRecord
validates :title, presence: true,
                    length: { minimum: 5 }
belongs_to :user
has_many :coments
accepts_nested_attributes_for :coments



  def calculate_coments
    write_attribute :total_coments, coments.map(&:id).size
    self.save
    self.total_coments
  end

  end
