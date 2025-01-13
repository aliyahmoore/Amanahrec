class Event < ApplicationRecord
    belongs_to :user
    has_many: user
    
    #Validations
    validates :name, presence: true
    validates :date, presence: true
    validates :location, presence: true
end
