class User < ApplicationRecord
  has_many :testimonials, dependent: :destroy
  belongs_to :role

  has_one :membership
  has_many :registrations
  has_many :activities, through: :registrations
  has_many :events, through: :registrations
  has_many :payments
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

  # method to check user roles add to
  def admin?
    role&.name&.downcase == "admin"
  end
end
