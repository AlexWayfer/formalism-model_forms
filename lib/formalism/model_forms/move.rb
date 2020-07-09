# frozen_string_literal: true

module Formalism
	module ModelForms
		## Base form for model moving
		module Move
			include Formalism::ModelForms::Base

			field :id, Integer

			attr_reader :direction

			def initialize(direction, id, how_many = 1)
				@direction = direction.to_sym
				@how_many = how_many.to_i

				super(id: id)
			end

			private

			POSSIBLE_DIRECTIONS = %i[up down].freeze

			def validate
				return if POSSIBLE_DIRECTIONS.include?(@direction)

				errors.add :direction, :unknown, args: { direction: @direction }
			end

			def execute
				instance.public_send(:"move_#{@direction}", @how_many)
				super
			end
		end
	end
end
