# frozen_string_literal: true

module Formalism
	module ModelForms
		module Conditions
			## Base class for `:condition` form field option
			class Base
				def initialize(name, value)
					@name = name
					@value = value
				end

				def result
					Sequel[@name => @value]
				end
			end
		end
	end
end
