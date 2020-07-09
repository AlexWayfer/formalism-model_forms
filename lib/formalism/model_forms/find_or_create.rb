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

					child_form.nested :find, child_form.namespace::Find,
						initialize: ->(form) { form.new(@params_or_instance) },
						errors_key: nil

					child_form.nested :create, child_form.namespace::Create,
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
