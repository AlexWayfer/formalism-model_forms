# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model updating
		module Update
			include Formalism::Form::Fields

			## Redefine `filed` and `nested` class methods with a specific `:default` from `instance`
			module ClassMethods
				%i[field nested].each do |method_name|
					define_method(method_name) do |name, type_or_form = nil, **options|
						unless method_name == :nested && options[:merge] == false
							options[:default] = options.fetch(
								:default, -> { instance&.public_send(name) }
							)
						end

						super(name, type_or_form, **options)
					end
				end
			end

			field :id, Integer, merge: false

			def initialize(params, id_or_instance)
				if id_or_instance.is_a?(model)
					self.instance = id_or_instance
				else
					self.id = id_or_instance
				end

				super params
			end

			private

			def validate
				return if instance

				add_error :itself, :not_exist
			end

			def execute
				instance.update(fields_and_nested_forms)
				super
			end

			def field_changed?(field)
				return true unless instance.respond_to?(field)

				public_send(field) != instance.public_send(field)
			end
		end
	end
end
