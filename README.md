# ExchangeRate

This gem can be used for currency conversion. The function .at accepts the input of date and two currencies and returns the exchange rate i.e. `ExchangeRate.at(Date.today,'GBP','USD')`. This gem has been made as part of a coding test.

## Installation

You can install this gem by running:

    $ gem install ExchangeRate

## Data

The data source for this currency converter is the [XML file](http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml) outputted every weekday by the European Central Bank (ECB). If a weekend date is inputted, the latest available date will be used.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ExchangeRate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ExchangeRate/blob/master/CODE_OF_CONDUCT.md).
