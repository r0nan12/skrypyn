class Article < ApplicationRecord
  attr_accessor :avatar_remote_url
  attr_accessor :delete_avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :title, presence: true,
                    length: { minimum: 5,maximum: 255 }
  validates :text, presence: true,
                    length: { minimum: 5 }
  belongs_to :user
  has_many :coments

  def avatar_remote_url=(url_value)
    self.avatar = URI.parse(url_value)
    @avatar_remote_url = url_value
  end

  def delete_avatar=(checked_value)
    self.update(avatar: nil) if checked_value == 'yes'
  end

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
