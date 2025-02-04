class User < ApplicationRecord
  has_and_belongs_to_many :events
  has_many :testimonials, dependent: :destroy
  belongs_to :role
  has_one :membership
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


end
