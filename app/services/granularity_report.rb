class GranularityReport < BaseService
  attr_reader :purchases, :granularity

  def initialize(purchases, granularity)
    @purchases = purchases
    @granularity = granularity
    super()
  end

  def call
    if valid_granularity?(granularity)
      @result = purchases.by_granularity(granularity)
    else
      @errors << { message: 'Invalid granularity' }
    end
  end

  private

  def valid_granularity?(granularity)
    %w[day week month year].include?(granularity)
  end

end
