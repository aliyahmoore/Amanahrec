class User < ApplicationRecord
  attr_accessor :country_code
  before_save :format_phone_number
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
         :secure_validatable








  validates :first_name, :last_name, :gender, :ethnicity, presence: true
  validates :email, email: true, uniqueness: true
  validates :phone_number, phone: { possible: true, allow_blank: false, types: [:mobile, :fixed_line] }
  validate :validate_phone_number

  def validate_phone_number
    # Format the phone number with country code
    full_number = "+#{country_code}#{phone_number.gsub(/\D/, '')}" if country_code.present? && phone_number.present?

    if full_number && !Phonelib.valid?(full_number)
      errors.add(:phone_number, "is not a valid phone number")
    end
  end

  def has_paid_for?(paymentable)
    payments.exists?(paymentable: paymentable, status: "succeeded")
  end

  def membership_active?
    membership&.active?
  end

  def format_phone_number
    puts "Country Code: #{country_code}"  # Debugging output
    if country_code.present? && phone_number.present? && !phone_number.start_with?("+")
      self.phone_number = "+#{country_code}#{phone_number.gsub(/\D/, '')}"
    end
  end
  

  def self.ransackable_attributes(auth_object = nil)
    [ "age_range", "email", "ethnicity", "first_name", "gender", "last_name", "phone_number", "role_id" ]
  end
end
