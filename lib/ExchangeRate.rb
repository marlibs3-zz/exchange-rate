# require "ExchangeRate/version"
require_relative "../data/RateParser"
require 'pp'

module ExchangeRate

  def self.get_currency_rate(parsed_rates_array, currency)
    parsed_rates_array = parsed_rates_array[0]["Cube"]
    currency_hash = parsed_rates_array.select{ |item| item["currency"] == currency }
    return currency_hash[0]["rate"].to_f
  end

  def self.get_rates_for_date(all_dates_array, selected_date)
    selected_date_rate_array = all_dates_array.select{ |item| item["time"] == selected_date.strftime("%F") }
    return selected_date_rate_array
  end

  def self.at(date, origin_currency, destination_currency)
    all_dates_array = RatesParser.parse()
    all_rates_for_date = get_rates_for_date(all_dates_array, date)

    origin_currency_rate = get_currency_rate(all_rates_for_date, origin_currency)
    destination_currency_rate = get_currency_rate(all_rates_for_date, destination_currency)
    origin_currency_multiplier = (1 / origin_currency_rate)
    destination_currency_multiplier = destination_currency_rate
    exchange_rate = (origin_currency_multiplier * destination_currency_multiplier).floor(4)

    puts "The exchange rate on " + date.to_s + " between " + origin_currency + " and " + destination_currency + " is: " + exchange_rate.to_s
  end

end

ExchangeRate.at(Date.new(2018, 6, 12),"GBP", "USD")
ExchangeRate.at(Date.new(2018, 6, 13),"GBP", "USD")
ExchangeRate.at(Date.new(2018, 6, 14),"GBP", "USD")
ExchangeRate.at(Date.new(2018, 6, 15),"GBP", "USD")
ExchangeRate.at(Date.yesterday,"GBP", "USD")