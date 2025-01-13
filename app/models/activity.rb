class Activity < ApplicationRecord
    belongs_to :user

    #Validations
    validates :name, presence: true
    validates :date, presence: true
end
