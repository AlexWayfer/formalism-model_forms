# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for many instances of model finding
		module Select
			include Formalism::ModelForms::Base
			extend ModelForms::Base::Plural

			field :id, Array, of: Integer, default: []

			def initialize(params_or_instance = {})
				## Instance should be an `Array` if there is not `params`
				params_or_instance = params_or_instance.to_a unless params_or_instance.is_a?(Hash)

				super
			end

			private

			def execute
				self.instance = @cached ? select_cached : dataset
			end

			def instance_respond_to?(name)
				@instance&.first&.respond_to?(name)
			end

			def instance_public_send(name)
				@instance.map { |instance| instance.public_send(name) }
			end
		end
	end
end
