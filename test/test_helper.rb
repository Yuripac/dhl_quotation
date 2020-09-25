require 'simplecov'
require 'simplecov-console'

SimpleCov.start

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ]
)

require 'minitest/autorun'
require 'dhl_quotation'
