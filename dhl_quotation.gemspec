require File.expand_path("../lib/dhl_quotation/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'dhl_quotation'
  s.summary = 'DHL Quotation'
  s.authors = 'Yuri Dias'
  s.version = DHLQuotation::VERSION
  s.files = Dir["test/**/*.rb", "{lib}/**/*.rb", "{config}/**/*.yml", "bin/*", "LICENSE", "*.md"]
  s.add_dependency 'savon', '~> 2.12.0'
  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'mocha', '~> 1.11'
  s.add_development_dependency 'simplecov', '~> 0.18'
end
