class User < ApplicationRecord
  has_many :testimonials, dependent: :destroy
  has_one :membership, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_many :registrations, dependent: :destroy
  has_many :activities, through: :registrations
  has_many :trips, through: :registrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :secure_validatable, :password_archivable








  validates :first_name, :last_name, :phone_number, :gender, :ethnicity, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email"}


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
