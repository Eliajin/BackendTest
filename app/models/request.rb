class Request < ApplicationRecord
    has_many :request_nacebel
    has_many :nacebel, through: :request_nacebel
end
