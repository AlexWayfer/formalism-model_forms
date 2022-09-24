# frozen_string_literal: true

require 'pry-byebug'

require 'simplecov'

if ENV['CI']
	require 'simplecov-cobertura'
	SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

SimpleCov.start

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

module MyProjectWithoutModelsYet
	module Forms
		class Base < Formalism::Form
		end
	end

	Formalism::ModelForms.define_for_project self
end
