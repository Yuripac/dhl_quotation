require File.expand_path("../lib/dhl_quotation/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'dhl_quotation'
  s.summary = 'DHL Quotation'
  s.authors = 'Yuri Dias'
  s.version = DHLQuotation::VERSION
  s.files = Dir["test/**/*.rb", "{lib}/**/*.rb", "{config}/**/*.yml", "bin/*", "LICENSE", "*.md"]
  s.add_dependency 'savon', '~> 2.12.0'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'simplecov'
end