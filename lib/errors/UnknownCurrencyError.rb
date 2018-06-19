class UnknownCurrencyError < StandardError

  def initialize(msg=nil)
    @message = msg
  end

  def message
    return "#{@message} is not a valid currency. Please enter a three-letter currency code."

  end

end