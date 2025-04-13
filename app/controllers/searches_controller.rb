class SearchesController < ApplicationController
    # def index
    # end

  def create
    query = params[:query]&.strip
    return head :bad_request if query.blank?

    ip_address = request.remote_ip
    search_query = SearchQuery.create!(query: query, ip_address: ip_address)

    SummarizeSearchJob.perform_async(search_query.id)

    render json: { results: [], query: query }, status: :created
  end

  def analytics
    summaries = SearchSummary.where(ip_address: request.remote_ip)
                              .order(search_count: :desc, last_searched_at: :desc)
                              .limit(10)
    render json: summaries.map { |s| { query: s.query, count: s.search_count, last_searched: s.last_searched_at } }
  end
end
