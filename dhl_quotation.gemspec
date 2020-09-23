require File.expand_path("../lib/dhl_quotation/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'dhl_quotation'
  s.summary = 'DHL Quotation'
  s.authors = 'Yuri Dias'
  s.version = DHLQuotation::VERSION
  s.files = Dir["{lib}/**/*.rb", "{config}/**/*.yml", "bin/*", "LICENSE", "*.md"]
  s.add_dependency 'savon', '~> 2.12.0'
end