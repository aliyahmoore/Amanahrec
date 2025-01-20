class User < ApplicationRecord
  has_many :testimonials, dependent: :destroy
  belongs_to :role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  


  validates :first_name, :last_name, :email, :phone_number, :gender, :ethnicity, presence: true

  def admin?
    role.name == 'admin'
  end

  def user?
    role.name == 'user'
  end
end
