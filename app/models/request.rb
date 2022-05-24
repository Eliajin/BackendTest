class Request < ApplicationRecord
    has_many :request_nacebel
    has_many :nacebel, through: :request_nacebel
    belongs_to :user

    validates :annualRevenue, presence: true
    validates :enterpriseNumber, presence: true, length: {minimum: 10, maximum: 10}
    validates :legalName, presence: true   
    
end
