require_relative "../../data/ecb_xml_handler"
require_relative "../errors/UnknownCurrencyError"
require_relative "../errors/DateNotFoundError"

module ExchangeRate

  def self.get_rates_for_date(all_dates_array, selected_date)
    selected_date_rate_array = all_dates_array.select{ |item| item["time"] == selected_date.strftime("%F") }
    if selected_date_rate_array.length == 0
      raise DateNotFoundError.new(selected_date.to_s)
    else
      return selected_date_rate_array
    end
  end

  def self.get_currency_rate(all_rates_per_date, currency)
    all_rates_per_date = all_rates_per_date[0]["Cube"]

    begin
      currency_hash = all_rates_per_date.select{ |item| item["currency"] == currency }
      return currency_hash[0]["rate"].to_f
    rescue NoMethodError
      raise UnknownCurrencyError.new(currency)
    end

  end

  def self.at(date, origin_currency, destination_currency)
    all_dates_array = ECBXMLHandler.parse

    all_rates_for_date = get_rates_for_date(all_dates_array, date)

    origin_currency_rate = get_currency_rate(all_rates_for_date, origin_currency)
    destination_currency_rate = get_currency_rate(all_rates_for_date, destination_currency)

    orig_currency_multiplier = (1 / origin_currency_rate)
    dest_currency_multiplier = destination_currency_rate

    exchange_rate = (orig_currency_multiplier * dest_currency_multiplier).floor(4)
    return exchange_rate

  end

end