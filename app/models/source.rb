class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify
end
