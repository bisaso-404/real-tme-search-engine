class SearchSummary < ApplicationRecord
    validates :query, :ip_address, presence: true
    validates :query, uniqueness: { scope: :ip_address}

end
