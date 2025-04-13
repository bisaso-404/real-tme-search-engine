class SearchQuery < ApplicationRecord
    validates :query, :ip_address, presence: true
end
