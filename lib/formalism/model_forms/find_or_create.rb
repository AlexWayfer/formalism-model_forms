# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model finding
		module FindOrCreate
			extend ::ModuleMethods::Extension

			## Module for class methods
			module ClassMethods
				def inherited(child_form)
					super

					child_form_path = File.dirname caller_locations(1..1).first.path
					%w[find create].each { |form_type| require "#{child_form_path}/#{form_type}" }

					child_form.define_nested_forms
				end

				protected

				def define_nested_forms
					nested :find, namespace::Find,
						initialize: ->(form) { form.new(@params_or_instance) },
						merge_errors: false

					nested :create, namespace::Create,
						initialize: ->(form) { form.new(@params_or_instance) },
						errors_key: nil,
						merge_errors: -> { find_form.instance.nil? }
				end
			end

			def initialize(params_or_instance = {})
				@params_or_instance = params_or_instance

				super
			end

			def instance
				find_form.instance || create_form.instance
			end

			private

			def execute
				self.instance = create_form.run.result unless instance.exists?
				instance
			end
		end
	end
end
