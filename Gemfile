# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rubocop', require: false if ENV['CI']

group :test do
  gem 'coveralls', require: false
  gem 'minitest'
  gem 'simplecov', require: false
  gem 'test-unit'
end
