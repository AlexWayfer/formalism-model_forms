# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model finding
		module Find
			include Formalism::ModelForms::Base
			include Memery

			primary_field :id, Integer, default: nil

			def initialize(params_or_instance = {})
				if params_or_instance.is_a?(Hash)
					super(params_or_instance)
				else
					@initialized_with_instance = true
					self.instance = params_or_instance
					super()
				end
			end

			def before_retry
				return if @initialized_with_instance

				super

				return unless instance_variable_defined? :@instance

				remove_instance_variable :@instance
			end

			private

			def execute
				self.instance = @cached ? find_cached : find_non_cached
			end

			def find_instance
				return unless valid?

				## `run` can return `nil` if form is not `runnable`
				run&.result
			end

			def find_cached
				dataset.find do |instance|
					fields_and_nested_forms.all? do |key, value|
						compare_value instance[key], value
					end
				end
			end

			def find_non_cached
				dataset.first
			rescue Sequel::DatabaseError => e
				## I'm not sure that there is safe to use
				## `Sequel::DatabaseError`
				raise e unless e.cause.is_a? PG::DataException
				raise e if e.cause.is_a? PG::InvalidTextRepresentation
			end

			memoize def dataset
				## `Dataset#all` for `EAGER` with `.first` in Find forms
				(@cached ? model : filtered_non_cached_dataset).all
			end

			memoize def filtered_non_cached_dataset
				unfiltered_non_cached_dataset.where(conditions_for_dataset)
			end

			memoize def unfiltered_non_cached_dataset
				(list_form_class&.new(params) || model).dataset
			end

			def list_form_class
				return unless namespace.const_defined?(:List) && namespace::List.is_a?(Class)

				namespace::List
			end
		end
	end
end
