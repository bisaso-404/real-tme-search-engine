class SummarizeSearchJob
  include Sidekiq::Job
  
  def perform(search_query_id)
    search_query = SearchQuery.find_by(id: search_query_id)
    return unless search_query
    
    ip = search_query.ip_address
    query = search_query.query.strip.downcase
    
    return unless query.present? && query.include?(" ") && query.length > 5
    
    SearchSummary.transaction do
      existing_summaries = SearchSummary.where(ip_address: ip)
      
      existing_summaries.each do |summary|
        existing_query = summary.query
        
        if query.include?(existing_query)
          summary.destroy
          next
        end
        
        if existing_query.include?(query)
          return
        end
      end
      
      summary = SearchSummary.lock.find_or_initialize_by(ip_address: ip, query: query)
      summary.search_count ||= 0
      summary.search_count += 1
      summary.last_searched_at = Time.current
      summary.save!
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("SearchQuery #{search_query_id} not found, retrying")
    raise
  end
end