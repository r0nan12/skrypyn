class Article < ApplicationRecord
  attr_reader :avatar_remote_url
  attr_reader :delete_avatar
  has_attached_file :avatar
  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] },
                       size: { less_than: 50.kilobytes }
  validates :title, presence: true,
                    length: { minimum: 5, maximum: 255 }
  validates :text, presence: true,
                   length: { minimum: 5 }
  validates :create_date, presence: true
  validates_date :create_date, is_at: lambda { Date.current },
                 invalid_date_message: 'is not correct',
                 is_at_message:  'must be at %{restriction}'
  validates :price, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  belongs_to :user
  has_many :coments, dependent: :destroy
  has_many :orders

  def avatar_remote_url=(url_value)
    if url_value.present?
      self.avatar = URI.parse(url_value)
    end
  end

  def delete_avatar=(checked_value)
    update(avatar: nil) if checked_value == 'yes'
  end

  def unsubscribed?(user)
    role = Role.find_by_name('admin')
    return false if user.role == role
    user.orders.each do |order|
      break if (order.article_id == id && order.approved?) || user_id == user.id
    end
  end

  def self.search(param)
    query = "%#{param}%"
    where('lower(title) LIKE ?', query)
  end
end
