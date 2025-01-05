# frozen_string_literal: true

require 'pry-byebug'

require 'simplecov'

if ENV['CI']
	require 'simplecov-cobertura'
	SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

SimpleCov.start

require_relative '../lib/formalism/model_forms'

## https://github.com/jeremyevans/sequel/blob/ce5b073/spec/model/spec_helper.rb

class << Sequel::Model
	attr_writer :db_schema

	alias orig_columns columns

	def columns(*cols)
		return super if cols.empty?

		define_method(:columns) { cols }
		alias_method(:columns, :columns)
		@dataset&.send(:columns=, cols)
		def_column_accessor(*cols)
		@columns = cols
		@db_schema = {}
		cols.each { |c| @db_schema[c] = {} }
	end
end

Sequel::DB = nil
Sequel::Model.use_transactions = false
Sequel::Model.cache_anonymous_models = false

db = Sequel.mock(fetch: { id: 42, name: 'Alex', age: 25 }, numrows: 1, autoid: proc { |_sql| 42 })

def db.schema(*)
	[[:id, { primary_key: true }]]
end

def db.reset
	sqls
end

def db.supports_schema_parsing?
	true
end

Sequel::Model.db = DB = db

## `stub_const` sets `.name` after `.inherited` of parent class
module MyProject
	module Models
		class User < Sequel::Model
			columns :id, :name, :age
		end
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

			class Find < Forms::Model::Find
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
