class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :activities

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :first_name, :last_name, :email, :phone_number, :gender, :ethnicity, presence: true
end
