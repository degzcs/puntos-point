class BaseService
  attr_reader :result, :errors

  def initialize
    @result = nil
    @errors = []
  end

  def call
    raise NotImplementedError
  end

  def valid?
    errors.nil? || errors.empty?
  end
end
