$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

if ENV["COVERAGE"]
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = if ENV['CODECLIMATE_REPO_TOKEN']
    SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::RcovFormatter,
    CodeClimate::TestReporter::Formatter]
  else
    SimpleCov::Formatter::RcovFormatter
  end
  SimpleCov.start(:rails)
end

require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'omniauth'
require 'omniauth-peppers'

RSpec.configure do |config|
  config.include WebMock::API
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, type: :strategy
end

