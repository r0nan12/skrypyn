class User < ApplicationRecord
  belongs_to :role
  has_many :articles
  has_many :coments, through: :articles
  validates :user_name,uniqueness: true
  before_create :addrole

  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def role?(role)
    self.role && self.role.name == role.to_s
  end
  private
  def addrole
    self.role = Role.find_by_name('author')
  end
end






