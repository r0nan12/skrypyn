class User < ApplicationRecord
  has_many :auths, dependent: :destroy
  belongs_to :role
  has_many :articles
  has_many :coments, through: :articles
  has_many :orders
  after_create :addrole

  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def auth_create(omniauth)
    self.email = omniauth['info']['email']
    self.password = Devise.friendly_token[0,20]
    auths.build(provider: omniauth['provider'], uid: omniauth['uid'])
  end

  def self.user_create(omniauth)
    user = where(email: omniauth['info']['email']).first
    if user
      user.auths.create(provider: omniauth['provider'], uid: omniauth['uid'])
    else
      user = new
      user.auth_create(omniauth)
      user.save!
    end
    user
  end

  def admin?
    role ==  Role.find_by_name('admin')
  end

  def author?
    role ==  Role.find_by_name('author')
  end

  def follower?
    role == Role.find_by_name('follower')
  end


  def subscribed?(article)
    orders.each do |order |
      article.id == order.article_id
    end
  end

  private

  def addrole
    role = Role.find_by_name('author')
    update(role: role) if self.role.nil?
  end
end
