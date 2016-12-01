class Article < ApplicationRecord
  attr_reader :avatar_remote_url
  attr_accessor :delete_avatar
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :avatar, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates :title, presence: true,
                    length: { minimum: 5, maximum: 255 }
  validates :text, presence: true,
                   length: { minimum: 5 }
  validates :create_date, presence: true
  belongs_to :user
  has_many :coments, dependent: :destroy

  def avatar_remote_url=(url_value)
    if url_value.present?
      self.avatar = URI.parse(url_value)
      @avatar_remote_url = url_value
    end
  end

  def delete_avatar=(checked_value)
    update(avatar: nil) if checked_value == 'yes'
  end

  def calculate_coments
    update_attribute :total_coments, coments.map(&:id).size
    total_coments
  end

  def self.search(param)
    query = "%#{param}%"
    where('lower(title) LIKE ?', query)
  end
end
