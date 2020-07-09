# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model creation
		module Create
			def initialize(*)
				super

				@instance_from_initialization = @instance

				initialize_instance
			end

			def before_retry
				super

				initialize_instance
			end

			private

			def execute
				instance.set(fields_and_nested_forms).save
				super
			end

			def find_instance
				nil
			end

			def initialize_instance
				self.instance = model.new fields(for_merge: true)
			end
		end
	end
end
