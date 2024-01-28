class Api::PurchasesController < Api::ApplicationController
  def index
    render json: purchases
  end

  def granularity_report
    granularity = params[:granularity] || 'day'

    result = purchases.by_granularity(granularity)
    result = result && result.map(&:attributes) || []
    render json: result
  end

  private

  def purchases
    filters = build_filters
    @purchases = if filters.any?
                   filters.inject(Purchase) do |purchases, filter|
                     purchases.send(filter[:name], *filter[:value])
                   end
                 else
                   Purchase.all_persisted
                 end
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