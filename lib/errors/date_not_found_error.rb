class DateNotFoundError < StandardError

  def initialize(msg=nil)
    @message = msg
  end

  def message
    return "There is no exchange rate data for #{@message}. Please ensure the date is a weekday within the last 90 days."
  end

end