require "test_helper"
require_relative "../lib/ExchangeRate"

class ExchangeRateTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ExchangeRate::VERSION
  end

  def test_hello_world
    assert_equal("Hello World!", ExchangeRate.hello_world)
  end

end
