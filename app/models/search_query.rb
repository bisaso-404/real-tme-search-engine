class SearchQuery < ApplicationRecord
    validate :query, ip_address, presence: true
end
