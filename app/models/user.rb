class User < ApplicationRecord
  has_many :testimonials, dependent: :destroy
  has_one :membership
  has_many :payments

  has_many :registrations
  has_many :activities, through: :registrations
  has_many :trips, through: :registrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable






  validates :first_name, :last_name, :email, :phone_number, :gender, :ethnicity, presence: true


  def has_paid_for?(paymentable)
    payments.exists?(paymentable: paymentable, status: "succeeded")
  end

  def membership_active?
    membership&.active?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "age_range", "email", "ethnicity", "first_name", "gender", "last_name", "phone_number", "role_id" ]
  end
end
