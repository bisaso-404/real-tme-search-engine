FactoryBot.define do
  factory :search_summary do
    ip_address { "MyString" }
    query { "MyString" }
    search_count { 1 }
    last_searched_at { "2025-04-12 11:11:39" }
  end
end
