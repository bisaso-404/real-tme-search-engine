class SearchSummary < ApplicationRecord
    validate :query, :ip_address, presence: true
    validate :query, uniqueness: { scope: :ip_address}

end
