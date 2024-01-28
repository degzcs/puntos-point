class FilterBuilder < BaseService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    @result = build_filters
  end

  def build_filters
    filters = []
    filters << build_range_filter
    filters << build_simple_id_filter(:customer_id)
    filters << build_simple_id_filter(:category_id)
    filters.compact
  end

  def build_simple_id_filter(name)
    return unless params[name]

    { name: "by_#{name}", value: [params[name]] }
  end

  def build_range_filter
    return unless params[:start_date] && params[:end_date]

    { name: :range, value: [params[:start_date], params[:end_date]] }
  end
end
