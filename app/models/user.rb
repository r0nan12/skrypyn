class User < ApplicationRecord
  belongs_to :role
  has_many :articles
  has_many :coments, through: :articles
  validates :user_name, uniqueness: true
  after_create :addrole

  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role ==  Role.find_by_name('admin')
  end

  def author?
    role ==  Role.find_by_name('author')
  end

  private

  def addrole
    role = Role.find_by_name('author')
    update(role: role) if self.role.nil?
  end
end
