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

## `stub_const` sets `.name` after `.inherited` of parent class
module MyProject
	module Models
		User = Struct.new(:id, :name, :age, keyword_init: true)
	end

	module Forms
		class Base < Formalism::Form
		end
	end

	Formalism::ModelForms.define_for_project self

	module Forms
		module User
			module Base
				include Formalism::Form::Fields

				field :name, String
				field :age, Integer
			end

			class Create < Forms::Model::Create
				include User::Base
			end

			class Update < Forms::Model::Update
				include User::Base
			end
		end
	end
end
