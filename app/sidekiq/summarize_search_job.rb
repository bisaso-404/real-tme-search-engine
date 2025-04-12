class SummarizeSearchJob
  include Sidekiq::Job
  sidekiq_options queue: 'search_summaries', retry: 3

  def perform(search_query_id)
    search_query = SearchQuery.find_by(search_query_id)
    return unless search_query

    ip = search_query.ip_address
    query = search_query.query.strip.downcase

    # skip if query is too short or incomplete (e.g., less that 3 words or no space)
    return unless query.match?(/\s/) && query.length > 5

    SearchSummary.transaction do
      summary = SearchSummary.lock.find_or_initialize_by(ip_address: ip, query: query)
      summary.search_count ||= 0
      summary.search_count += 1
      summary.last_searched_at = Time.current
      summary.save!
    end

  rescue ActiveRecord::RecordNotFound
    # Handle the case where the search query is not found

    retry

    # Do something
  end
end
