# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb
require 'faker'

puts "Seeding search data..."

ips = Array.new(5) { Faker::Internet.unique.ip_v4_address }

# Simulated search sessions for each IP
search_sessions = {
  ips[0] => [
    "What",
    "What is",
    "What is a",
    "What is a good car"
  ],
  ips[1] => [
    "How",
    "How is",
    "How is Emil Hajric",
    "How is Emil Hajric doing"
  ],
  ips[2] => [
    "Learn",
    "Learn to",
    "Learn to cook pasta"
  ],
  ips[3] => [
    "Best",
    "Best programming",
    "Best programming languages",
    "Best programming languages to learn"
  ],
  ips[4] => [
    "Ruby",
    "Ruby on",
    "Ruby on Rails tutorials"
  ]
}

search_sessions.each do |ip, queries|
  queries.each_with_index do |query, i|
    # Simulate real-time typing with timestamps
    created_at = Time.now - (queries.length - i).minutes

    sq = SearchQuery.create!(
      query: query,
      ip_address: ip,
      created_at: created_at,
      updated_at: created_at
    )

    # Simulate Sidekiq worker logic for valid queries
    if query.length > 5 && query.match?(/\s/)
      normalized_query = query.strip.downcase
      summary = SearchSummary.find_or_initialize_by(ip_address: ip, query: normalized_query)
      summary.search_count ||= 0
      summary.search_count += 1
      summary.last_searched_at = created_at
      summary.save!
    end
  end
end

puts "Seeded #{SearchQuery.count} search queries and #{SearchSummary.count} summaries."

