class User < ApplicationRecord
  belongs_to :role
has_many :articles
has_many :coments, through: :articles
  after_create :addrole

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def role?
      self.role.name
  end


  private

  def addrole
    self.update_column(:role_id, 2)
  end

  end






