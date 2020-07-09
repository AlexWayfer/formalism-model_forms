# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
	add_filter '/spec/'
end
SimpleCov.start

if ENV['CODECOV_TOKEN']
	require 'codecov'
	SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'pry-byebug'

require_relative '../lib/formalism/model_forms'