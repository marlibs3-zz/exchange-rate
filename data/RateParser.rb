require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/hash/conversions'
require 'pp'

class RatesParser

  def self.parse
    file = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"))
    hash = Hash.from_xml(file.to_s)
    return hash["Envelope"]["Cube"]["Cube"]
  end

end