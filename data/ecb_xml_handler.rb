require 'open-uri'
require 'pp'
require 'net/http'
require 'xmlsimple'
require 'pry'

class ECBXMLHandler

  XML_FILE = "/tmp/eurofxref-hist-90d.xml"

  def self.fetch
    uri = URI("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    resp = Net::HTTP.get(uri)
    open(XML_FILE, "wb") do |file|
      file.write(resp)
    end
  end

  def self.parse
    hash = XmlSimple.xml_in(XML_FILE)
    return hash["Cube"][0]["Cube"]
  end

end