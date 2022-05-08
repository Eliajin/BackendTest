class Nacebel < ApplicationRecord
    has_many :request_nacebel
    has_many :requests, through: :request_nacebel
end