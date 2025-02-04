class User < ApplicationRecord
  has_many :events
  has_many :testimonials, dependent: :destroy
  belongs_to :role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable




  validates :first_name, :last_name, :email, :phone_number, :gender, :ethnicity, presence: true

  has_many :payments

  def has_paid_for?(paymentable)
    payments.exists?(paymentable: paymentable, status: "succeeded")
  end

  has_one :membership
end
