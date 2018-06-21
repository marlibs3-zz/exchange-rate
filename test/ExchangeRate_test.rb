require "test_helper"

require_relative "../data/ecb_xml_handler"
require_relative "../lib/ExchangeRate/ExchangeRate"
require_relative "../lib/errors/UnknownCurrencyError"
require_relative "../lib/errors/DateNotFoundError"

class ExchangeRateTest < Minitest::Test

  def setup
    ECBXMLHandler.fetch
    @all_dates_array = ECBXMLHandler.parse
    @one_date_array = [{"time"=>"2018-06-18", "Cube"=> [{"currency"=>"USD", "rate"=>"1.1613"}, {"currency"=>"JPY", "rate"=>"128.27"}, {"currency"=>"BGN", "rate"=>"1.9558"}, {"currency"=>"CZK", "rate"=>"25.739"}, {"currency"=>"DKK", "rate"=>"7.45"}, {"currency"=>"GBP", "rate"=>"0.87655"}, {"currency"=>"HUF", "rate"=>"323.02"}, {"currency"=>"PLN", "rate"=>"4.2876"}, {"currency"=>"RON", "rate"=>"4.6658"}, {"currency"=>"SEK", "rate"=>"10.2223"}, {"currency"=>"CHF", "rate"=>"1.1554"}, {"currency"=>"ISK", "rate"=>"125.7"}, {"currency"=>"NOK", "rate"=>"9.434"}, {"currency"=>"HRK", "rate"=>"7.3795"}, {"currency"=>"RUB", "rate"=>"73.4609"}, {"currency"=>"TRY", "rate"=>"5.4821"}, {"currency"=>"AUD", "rate"=>"1.561"}, {"currency"=>"BRL", "rate"=>"4.3472"}, {"currency"=>"CAD", "rate"=>"1.5307"}, {"currency"=>"CNY", "rate"=>"7.478"}, {"currency"=>"HKD", "rate"=>"9.1156"}, {"currency"=>"IDR", "rate"=>"16348.9"}, {"currency"=>"ILS", "rate"=>"4.2146"}, {"currency"=>"INR", "rate"=>"79.0145"}, {"currency"=>"KRW", "rate"=>"1282.56"}, {"currency"=>"MXN", "rate"=>"23.9739"}, {"currency"=>"MYR", "rate"=>"4.6423"}, {"currency"=>"NZD", "rate"=>"1.6712"}, {"currency"=>"PHP", "rate"=>"62.013"}, {"currency"=>"SGD", "rate"=>"1.568"}, {"currency"=>"THB", "rate"=>"37.951"}, {"currency"=>"ZAR", "rate"=>"15.6275"}]}]
    @all_rates_per_date = ExchangeRate.get_rates_for_date(@all_dates_array, Date.new(2018, 6, 18))
  end

  def test_can_get_rates_for_date__valid_date
    assert_equal(@one_date_array, ExchangeRate.get_rates_for_date(@all_dates_array, Date.new(2018, 6, 18)))
  end

  def test_can_get_rates_for_rate__invalid_date___past
    error = assert_raises(DateNotFoundError) {ExchangeRate.get_rates_for_date(@all_dates_array, Date.new(2017, 6, 18))}
    assert_equal("There is no exchange rate data for 2017-06-18. Please ensure the date is a weekday within the last 90 days.", error.message)
  end

  def test_can_get_rates_for_rate__invalid_date___weekend
    error = assert_raises(DateNotFoundError) {ExchangeRate.get_rates_for_date(@all_dates_array, Date.new(2018, 6, 17))}
    assert_equal("There is no exchange rate data for 2018-06-17. Please ensure the date is a weekday within the last 90 days.", error.message)
  end

  def test_can_get_rates_for_rate__invalid_date___future
    error = assert_raises(DateNotFoundError) {ExchangeRate.get_rates_for_date(@all_dates_array, Date.new(2019, 6, 18))}
    assert_equal("There is no exchange rate data for 2019-06-18. Please ensure the date is a weekday within the last 90 days.", error.message)
  end

  def test_can_get_currency_rate__valid_currency
    assert_equal(0.87655, ExchangeRate.get_currency_rate(@all_rates_per_date, "GBP"))
  end

  def test_can_get_currency_rate__invalid_currency___string
    error = assert_raises(UnknownCurrencyError) {ExchangeRate.get_currency_rate(@all_rates_per_date, "TEST")}
    assert_equal("TEST is not a valid currency. Please enter a three-letter currency code.", error.message)
  end

  def test_can_get_currency_rate__invalid_currency___int
    error = assert_raises(UnknownCurrencyError) {ExchangeRate.get_currency_rate(@all_rates_per_date, "123")}
    assert_equal("123 is not a valid currency. Please enter a three-letter currency code.", error.message)
  end

  def test_can_exchange_currency__today
    assert_equal(1.3152, ExchangeRate.at(Date.new(2018, 6, 19),'GBP','USD'))
  end

end
