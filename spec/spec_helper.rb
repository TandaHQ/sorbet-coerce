# typed: strict

require "debug"
require "simplecov"
require "simplecov-cobertura"

SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end
