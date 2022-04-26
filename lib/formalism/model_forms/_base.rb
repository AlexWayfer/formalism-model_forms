# frozen_string_literal: true

require 'forwardable'
require 'gorilla_patch/inflections'
require 'gorilla_patch/namespace'
require 'memery'
require 'sequel'

module Formalism
	module ModelForms
		## Base form for models
		module Base
			extend ::ModuleMethods::Extension
			include Formalism::Form::Fields

			# TODO: Check
			extend Forwardable
			def_delegators(
				'self.class',
				:primary_field_name, :namespace, :model_name, :model, :instance_variable_name
			)

			## Module for Base form class methods
			module ClassMethods
				include Memery

				def inherited(form)
					super

					form.primary_field_name = primary_field_name

					return if form.instance_name == :model
					return if form.method_defined?(form.instance_name.to_s)

					form.alias_method form.instance_name, :instance
					form.alias_method "#{form.instance_name}=", :instance=
				end

				def included(something)
					super
					something.primary_field_name = primary_field_name
				end

				attr_accessor :primary_field_name

				def primary_field(name, *args, **kwargs)
					remove_field primary_field_name if primary_field_name

					field name, *args, **kwargs

					self.primary_field_name = name
				end

				def remove_field(name)
					super

					self.primary_field_name = nil if name == primary_field_name
				end

				using GorillaPatch::Namespace
				using GorillaPatch::Inflections

				memoize def namespace
					self::FORMS_NAMESPACE.const_get(deconstantize)
				end

				memoize def model_name
					deconstantize.split('::')[2..].reverse
						.find { |part| self::MODELS_NAMESPACE&.const_defined?(part, false) || part == 'Model' }
				end

				memoize def model
					self::MODELS_NAMESPACE.const_get(model_name, false)
				end

				memoize def instance_name
					model_name.underscore.to_sym
				end

				memoize def instance_variable_name
					:"@#{instance_name}"
				end
			end

			def initialize(*)
				@cached =
					Sequel::Plugins.const_defined?(:StaticCache) &&
					model.plugins.include?(Sequel::Plugins::StaticCache)

				super
			end

			def before_retry
				if instance_variable_defined?(instance_variable_name)
					remove_instance_variable instance_variable_name
				end

				super
			end

			def instance
				return @instance if defined?(@instance)

				@instance = find_instance
			end

			private

			def execute
				# TODO: Check
				Actions::Application::Restart.run if @cached && ENV.fetch('RACK_ENV') != 'test'

				instance
			end

			attr_writer :instance

			def find_instance
				model
					.first(primary_field_name => public_send(primary_field_name))
					.public_send(@cached ? :dup : :itself)
			end

			def field_condition(name, value)
				options = self.class.fields_and_nested_forms[name]

				return instance_exec(name, value, &options[:condition]) if options.key?(:condition)

				field_condition_class(options[:type]).new(name, value).result
			end

			using GorillaPatch::Inflections

			def field_condition_class(type)
				const_name = type.to_s.camelize
				const_name = 'Base' if const_name.empty? || !Conditions.const_defined?(const_name, false)

				Conditions.const_get(const_name, false)
			end

			def conditions_for_dataset(except: [])
				conditions = fields_and_nested_forms.map do |name, value|
					next Sequel[true] if Array(except).include?(name)

					field_condition(name, value)
				end

				## `[].reduce(:&)` returns `nil`
				conditions.any? ? conditions.reduce(:&) : conditions
			end

			def compare_value(instance_value, value)
				## It can be Number, nil, etc., but logic for Regexp is below
				instance_value = instance_value.to_s if value.is_a?(String) && !instance_value.is_a?(Regexp)

				## Match instead of equal if any side is Regexp
				if instance_value.is_a?(Regexp) || value.is_a?(Regexp)
					instance_value.match? value
				## And just equal if not
				else
					instance_value == value
				end
			end

			def select_cached
				model.all.select do |instance|
					fields_and_nested_forms.all? do |key, values|
						key =
							self.class.fields_and_nested_forms[key].fetch(:compare_key, key)

						Array(values).any? do |value|
							compare_value instance.public_send(key), value
						end
					end
				end
			end

			# Pluralizes instance_method name
			module Plural
				include Base
				include Memery

				using GorillaPatch::Inflections.from_sequel

				memoize def instance_name
					model_name.underscore.pluralize.to_sym
				end
			end
		end
	end
end
