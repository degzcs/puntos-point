class Api::PurchasesController < Api::ApplicationController
  def index
    render json: serialize_response(purchases)
  end

  def granularity_report
    granularity = params[:granularity] || 'day'

    service = GranularityReport.new(purchases, granularity)
    service.call
    response = service.valid? ? service.result : service.errors

    render json: serialize_response(response)
  end

  private

  def purchases
    service = FilterBuilder.new(params)
    service.call
    return [] unless service.valid?

    filters = service.result
    if filters.any?
      filters.inject(Purchase) do |purchases, filter|
        purchases.send(filter[:name], *filter[:value])
      end
    else
      Purchase.all_persisted
    end
  end
end
